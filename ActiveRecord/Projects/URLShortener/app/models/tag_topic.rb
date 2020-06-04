# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TagTopic < ApplicationRecord

    validates :topic, presence: true
    validates :topic, uniqueness: true

    has_many(
        :taggings,
        class_name: 'Tagging',
        foreign_key: :topic_id,
        primary_key: :id
    )

    has_many :urls, through: :taggings, source: :url

    def popular_links
        data = self.urls.limit(5)

        data.each do |url|
            s = url.short_url
            t = url.num_clicks

            print s
            print t
        end

    end

end
