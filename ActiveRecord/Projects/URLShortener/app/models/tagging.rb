# == Schema Information
#
# Table name: taggings
#
#  id         :bigint           not null, primary key
#  topic_id   :integer
#  url_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tagging < ApplicationRecord
    validates :topic_id, :url_id, presence: true

    belongs_to(
        :tag_topic,
        class_name: 'TagTopic',
        foreign_key: :topic_id,
        primary_key: :id
    )

    belongs_to(
        :url,
        class_name: 'ShortenedUrl',
        foreign_key: :url_id,
        primary_key: :id
    )

end
