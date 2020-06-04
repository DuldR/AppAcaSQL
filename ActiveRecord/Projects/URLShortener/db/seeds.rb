# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(email: "footballluvr69@foosball.com")

User.create!(email: "putsorcalls@bets.com")

User.create!(email: "redditor@reddit.com")

ShortenedUrl.create!(short_url: "eYvhw-k81SrWvt6GAGeqCQ", long_url: "espn.com", user_id: 1, created_at: Time.current, updated_at: Time.current)

ShortenedUrl.create!(short_url: "rVRh-kkIp5joADIWjwCCUw", long_url: "cfb.com", user_id: 1, created_at: Time.current, updated_at: Time.current)

ShortenedUrl.create!(short_url: "lf0QTA2nNfGh4zOvbhvWCQ", long_url: "sbnation.com", user_id: 1, created_at: Time.current, updated_at: Time.current)

ShortenedUrl.create!(short_url: "5JwC8AZvI1CxPiEuqaSAbA", long_url: "reddit.com", user_id: 3, created_at: Time.current, updated_at: Time.current)

ShortenedUrl.create!(short_url: "BHj2nMDDKyKRBLWb1EanOQ", long_url: "barstool.com", user_id: 1, created_at: Time.current, updated_at: Time.current)

ShortenedUrl.create!(short_url: "fPd3EUWSwiziX3eQAASOFg", long_url: "schwab.com", user_id: 2, created_at: Time.current, updated_at: Time.current)

ShortenedUrl.create!(short_url: "oLvJRHrA6pZynaw2wCwm6Q", long_url: "robinhood.com", user_id: 2, created_at: Time.current, updated_at: Time.current)

ShortenedUrl.create!(short_url: "YV9s3W64NIQLBWO9fx9kgw", long_url: "football.com", user_id: 1, created_at: Time.current, updated_at: Time.current)

TagTopic.create!(topic: "football", created_at: Time.current, updated_at: Time.current)

TagTopic.create!(topic: "options", created_at: Time.current, updated_at: Time.current)

TagTopic.create!(topic: "misc", created_at: Time.current, updated_at: Time.current)

Visit.create!(user_id: 1, url_id: 1, created_at: Time.current, updated_at: Time.current)

Visit.create!(user_id: 1, url_id: 2, created_at: Time.current, updated_at: Time.current)

Visit.create!(user_id: 1, url_id: 3, created_at: Time.current, updated_at: Time.current)

Visit.create!(user_id: 1, url_id: 2, created_at: Time.current, updated_at: Time.current)

Visit.create!(user_id: 2, url_id: 6, created_at: Time.current, updated_at: Time.current)

Tagging.create!(topic_id: 1, url_id: 1, created_at: Time.current, updated_at: Time.current)

Tagging.create!(topic_id: 1, url_id: 2, created_at: Time.current, updated_at: Time.current)

Tagging.create!(topic_id: 1, url_id: 3, created_at: Time.current, updated_at: Time.current)

Tagging.create!(topic_id: 2, url_id: 6, created_at: Time.current, updated_at: Time.current)

Tagging.create!(topic_id: 2, url_id: 7, created_at: Time.current, updated_at: Time.current)


