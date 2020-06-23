# == Schema Information
#
# Table name: responses
#
#  id         :bigint           not null, primary key
#  answer_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Response < ApplicationRecord

    belongs_to  :respondent,
     class_name: :User,
     foreign_key: :user_id,
     primary_key: :id

    belongs_to  :answer,
     class_name: :AnswerChoice,
     foreign_key: :answer_id,
     primary_key: :id


    has_one :question, through: :answer

    
    def sibling_response

        self.question.responses.where.not(id: self.id)

    end
end
