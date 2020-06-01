class ShortenedUrl < ApplicationRecord

    validates :name, :short_url, presence: true
    validates :short_url, uniqueness: true


    def self.random_code
        print SecureRandom::urlsafe_base64
    end



end