# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  poll_id    :integer          not null
#  q_body     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord

    belongs_to :poll,
        class_name: :Poll,
        foreign_key: :poll_id,
        primary_key: :id

    has_many :answers,
        class_name: :AnswerChoice,
        foreign_key: :q_id,
        primary_key: :id


end
