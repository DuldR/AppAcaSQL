require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User

  attr_accessor :id, :fname, :lname

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum) }
  end

  def self.find_by_name(first, last)
    data = QuestionsDatabase.instance.execute("SELECT * FROM users WHERE fname = ? AND lname = ?", first, last)
    data.map {|datum| User.new(datum) }
  end

  def self.find_by_id(userid)
    data = QuestionsDatabase.instance.execute("SELECT * FROM users WHERE users.id = ?", userid)
    data.map {|datum| User.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

end

class Question

  attr_accessor :id, :title, :body, :user_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_author_id(auth_id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions WHERE user_id = ?", auth_id)
    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(self.user_id)
  end

end

class Reply

  attr_accessor :id, :user_id, :question_id, :top_reply_id, :body

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_user_id(auth_id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE user_id = ?", auth_id)
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(auth_id)
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE question_id = ?", auth_id)
    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @top_reply_id = options['top_reply_id']
    @body = options['body']
  end

end