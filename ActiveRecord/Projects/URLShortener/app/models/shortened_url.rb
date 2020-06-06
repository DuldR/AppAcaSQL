# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string
#  long_url   :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord

    validates :user_id, :short_url, presence: true
    validates :short_url, uniqueness: true

    belongs_to(
        :user,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_many(
        :visits,
        class_name: 'Visit',
        foreign_key: :url_id,
        primary_key: :id
    )

    has_many(
        :taggings,
        class_name: 'Tagging',
        foreign_key: :url_id,
        primary_key: :id
    )

    has_many :visitors, through: :visits, source: :user, dependent: :destroy

    has_many :tags, through: :taggings, source: :tag_topic, dependent: :destroy

    has_many :uniq_vis, Proc.new { distinct }, through: :visits, source: :user, dependent: :destroy

    # Singular query version.

    #      def self.prune(n)
    #     ShortenedUrl
    #       .joins(:submitter)
    #       .joins('LEFT JOIN visits ON visits.shortened_url_id = shortened_urls.id')
    #       .where("(shortened_urls.id IN (
    #         SELECT shortened_urls.id
    #         FROM shortened_urls
    #         JOIN visits
    #         ON visits.shortened_url_id = shortened_urls.id
    #         GROUP BY shortened_urls.id
    #         HAVING MAX(visits.created_at) < \'#{n.minute.ago}\'
    #       ) OR (
    #         visits.id IS NULL and shortened_urls.created_at < \'#{n.minutes.ago}\'
    #       )) AND users.premium = \'f\'")
    #       .destroy_all

    #     # The sql for the query would be:
    #     #
    #     # SELECT shortened_urls.*
    #     # FROM shortened_urls
    #     # JOIN users ON users.id = shortened_urls.submitter_id
    #     # LEFT JOIN visits ON visits.shortened_url_id = shortened_urls.id
    #     # WHERE (shortened_urls.id IN (
    #     #   SELECT shortened_urls.id
    #     #   FROM shortened_urls
    #     #   JOIN visits ON visits.shortened_url_id = shortened_urls.id
    #     #   GROUP BY shortened_urls.id
    #     #   HAVING MAX(visits.created_at) < "#{n.minute.ago}"
    #     # ) OR (
    #     #   visits.id IS NULL and shortened_urls.created_at < '#{n.minutes.ago}'
    #     # )) AND users.premium = 'f'
    #   end

    def self.prune(n)

        ShortenedUrl.all.each do |url|
            if url.visitors.count == 0 && !url.created_at.between?(n.minutes.ago, Time.current) && url.nonpremium_max == false
                url.destroy
            end
        end

    end

    def self.random_code
        not_yet = 0
        until not_yet == 1
            dankaku = SecureRandom::urlsafe_base64
            if self.exists?(:short_url => dankaku) == false
                not_yet = 1
            end
        end

        dankaku
    end

    #This is what they define as a factory method. *shrugs* Doesn't match waht the internet defines as a factory method.
    def self.create_url(user, long_url)
        ShortenedUrl.create!(
            user_id: user.id,
            long_url: long_url,
            short_url: ShortenedUrl.random_code
        )
    end

    # Controls how many URLs can be made.

    def no_spamming
        if self.user.submitted_urls.where(created_at: 1.minutes.ago..Time.current).count >= 5 && nonpremium_max == false
            errors[:user_id] << "You can only submit 5 URLs within 1 minute."
        end

    end

    def nonpremium_max
        self.user.premium
    end


    #Much easier than I thought. You don't need to add any raw SQL.
    def num_clicks
        self.visitors.count
    end

    def num_uniques
        self.uniq_vis.count
    end

    def num_uniq_recent
        self.uniq_vis.where(created_at: 60.minutes.ago..Time.current).count
    end


end
