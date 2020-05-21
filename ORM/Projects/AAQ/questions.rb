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

    data = QuestionsDatabase.instance.execute(<<-SQL, first, last)

    SELECT
    *
    FROM
    users
    WHERE
    fname = ? AND lname = ?

    SQL

    data.map {|datum| User.new(datum) }
  end

  def self.find_by_id(userid)
    data = QuestionsDatabase.instance.execute(<<-SQL, userid)

    SELECT
    *
    FROM
    users
    WHERE
    users.id = ?

    SQL
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

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end

end

class Question

  attr_accessor :id, :title, :body, :user_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_author_id(auth_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, auth_id)

    SELECT
    *
    FROM
    questions
    WHERE user_id = ?

    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_question_id(auth_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, auth_id)

    SELECT
    *
    FROM
    questions
    WHERE 
    id = ?

    SQL
    
    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
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

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollow.follows_for_question_id(self.id)
  end

  def likers
    QuestionLike.likers_for_question(self.user_id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end


end

class Reply

  attr_accessor :id, :user_id, :question_id, :top_reply_id, :body

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  #Not gonna heredoc these as, I think I get the point.
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

  def author
    User.find_by_id(self.user_id)
  end

  def question
    Question.find_by_question_id(self.question_id)
  end

  def parent_reply
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE id = ?", self.top_reply_id)
    data.map { |datum| Reply.new(datum) }
  end

  def child_replies
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies WHERE top_reply_id = ?", self.id)
    data.map { |datum| Reply.new(datum) }
  end

end

class QuestionFollow

  #These definitely needed to be heredoc'd.
  def self.follows_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)

    SELECT
    users.id, fname, lname
    FROM
    questions_follows
    LEFT JOIN 
    users ON questions_follows.user_id = users.id
    WHERE
    question_id = ?

    SQL
    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)

    SELECT
    questions.id, questions.title, questions.body, questions.user_id
    FROM
    questions_follows
    LEFT JOIN
    questions ON questions_follows.user_id = questions.user_id
    WHERE
    question_id = ?

    SQL
    
    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)

    # I'll keep this here. This provides THE MOST followed question
    # SELECT MAX(question_id) FROM (SELECT question_id, COUNT(question_id) AS count FROM questions_follows GROUP BY question_id);
    #  Round 2
    # SELECT questions.title, questions.body, questions.user_id, COUNT(question_id) AS count FROM questions_follows LEFT JOIN questions ON questions_follows.question_id = questions.id GROUP BY questions_follows.question_id ORDER BY count DESC LIMIT 1 OFFSET ? - 1;

    data = QuestionsDatabase.instance.execute(<<-SQL, n)

    SELECT
    questions.id, questions.title, questions.body, questions.user_id, COUNT(questions_follows.question_id) AS count
    FROM
    questions_follows
    LEFT JOIN 
    questions
    ON questions_follows.question_id = questions.id 
    GROUP BY
    questions_follows.question_id
    ORDER BY
    count DESC
    LIMIT ?
    SQL

    data.map { |datum| Question.new(datum) }

  end
    

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end


end

class QuestionLike

  def self.likers_for_question(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)

    SELECT
    users.id, fname, lname
    FROM 
    questions_liked
    LEFT JOIN
    users ON questions_liked.user_id = users.id
    WHERE
    questions_liked.question_id = ?

    SQL

    data.map { |datum| User.new(datum) }

  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)

    SELECT
    COUNT(question_id) AS count
    FROM
    questions_liked
    WHERE
    question_id = ?
    GROUP BY
    question_id

    SQL

    data[0]["count"]
  end

  def self.liked_questions_for_user_id(user_id)

    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)

    SELECT
    questions.id, questions.title, questions.body, questions.user_id
    FROM
    questions_liked
    LEFT JOIN
    questions ON questions_liked.question_id = questions.id
    WHERE
    questions_liked.user_id = ?

    SQL

    data.map { |datum| Question.new(datum) }

  end

  def self.most_liked_questions(n)

    data = QuestionsDatabase.instance.execute(<<-SQL, n)


    SELECT
    questions.id, questions.title, questions.body, questions.user_id, COUNT(questions_liked.question_id) AS count
    FROM
    questions_liked
    LEFT JOIN 
    questions
    ON questions_liked.question_id = questions.id 
    GROUP BY
    questions_liked.question_id
    ORDER BY
    count DESC
    LIMIT ?

    SQL

    data.map { |datum| Question.new(datum) }

  end



  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

end