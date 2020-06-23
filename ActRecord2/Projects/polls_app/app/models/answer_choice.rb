# == Schema Information
#
# Table name: answer_choices
#
#  id         :bigint           not null, primary key
#  q_id       :integer          not null
#  a_body     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AnswerChoice < ApplicationRecord

    validates :a_body, presence: true

    belongs_to :question,
        class_name: :Question,
        foreign_key: :q_id,
        primary_key: :id

    has_many :responses,
        class_name: :Response,
        foreign_key: :answer_id,
        primary_key: :id


end
