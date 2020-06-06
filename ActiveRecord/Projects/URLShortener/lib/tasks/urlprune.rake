namespace :urlprune do

    desc "Prunes URLs that have not been visited in the last 15 minutes."
    task prune_old_urls: :environment do
        puts "Purging old URLs..."
        ShortenedUrl.prune(15)
    end

end