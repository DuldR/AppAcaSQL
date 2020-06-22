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


end
