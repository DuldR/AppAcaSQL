# == Schema Information
#
# Table name: responses
#
#  id          :bigint           not null, primary key
#  answer_id   :integer          not null
#  question_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Response < ApplicationRecord

    belongs_to  :user,
     class_name: :User,
     foreign_key: :user_id,
     primary_key: :id
end