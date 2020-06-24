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

    validates :q_body, presence: true

    belongs_to :poll,
        class_name: :Poll,
        foreign_key: :poll_id,
        primary_key: :id

    has_many :answers,
        class_name: :AnswerChoice,
        foreign_key: :q_id,
        primary_key: :id

    has_many :responses, through: :answers

    def results
        # N + 1 Slowest
        # data = self.answers
        # responses = {}

        # data.each do |ans|
        #     responses[ans.a_body] = ans.responses.count
        # end

        # responses

        # Includes to pre-fetch the data to reduce query count. A whole millisecond faster!

        # data = self.answers.includes(:responses)
        # responses = {}

        # data.each do |ans|
        #     responses[ans.a_body] = ans.responses.length
        # end

        # responses

        # Active Record Way - Uh, includes is faster by a half a millisecond. Is this truly better? Apparently, includes sends data to the client which is uneccessary. 

        data = self.answers
            .select('answer_choices.*, COUNT(responses.id) AS resp_count')
            .left_outer_joins(:responses)
            .group("answer_choices.id")

        data.inject({}) do |results, ac|
            results[ac.a_body] = ac.resp_count; results
        end



    end
end
