class ShortenedUrl < ApplicationRecord

    validates :user_id, :short_url, presence: true
    validates :short_url, uniqueness: true


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