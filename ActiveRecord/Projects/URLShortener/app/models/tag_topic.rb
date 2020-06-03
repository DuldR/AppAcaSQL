# == Schema Information
#
# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  url_id     :integer
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TagTopic < ApplicationRecord

    has_many(
        :taggings,
        class_name: 'Tagging',
        foreign_key: :topic_id,
        primary_key: :id
    )

end
