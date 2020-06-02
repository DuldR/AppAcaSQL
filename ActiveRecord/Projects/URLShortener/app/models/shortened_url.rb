class ShortenedUrl < ApplicationRecord

    validates :name, :short_url, presence: true
    validates :short_url, uniqueness: true


    def self.random_code
        print :short_url
    end



end