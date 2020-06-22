# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(username: "NPRLuvr69")
User.create!(username: "FoxNewsFan420")

Poll.create!(title: "AOC", user_id: 1)
Poll.create!(title: "Mcconnell", user_id: 2)

Question.create!(poll_id: 1, q_body:"Do you think AOC is a qt 3.14?")

Question.create!(poll_id: 2, q_body:"Is McConnell turtley enough for the turtle club?")

AnswerChoice.create!(q_id: 1, a_body: "Yes.")
AnswerChoice.create!(q_id: 1, a_body: "No.")
AnswerChoice.create!(q_id: 1, a_body: "Hells Yet.")
AnswerChoice.create!(q_id: 2, a_body: "He's fine!")
AnswerChoice.create!(q_id: 2, a_body: "Turtle!")

Response.create!(answer_id: 1, user_id: 1)