require 'sqlite3'
require 'singleton'

class QuestionDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User 
    attr_accessor :lname, :fname

    def self.find_by_id(id)
        user = QuestionDBConnection.instance.execute(<<-SQL, id)
            SELECT
              *
            FROM 
              users
            WHERE
              id = ?
        SQL
        return nil unless user.length > 0
        User.new(user.first)
    end

    def self.find_by_name(fname,lname)
        fullname = QuestionDBConnection.instance.execute(<<-SQL, fname, lname)
            SELECT
              *
            FROM
              users
            WHERE
              fname = ? AND lname = ?
        SQL
        return nil unless fullname.length >0
        User.new(fullname.first)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
end

class Question
    attr_accessor :id, :title, :body, :author_id
    def initialize(options)
         @id = options['id']
         @title = options['title']
         @body = options['body']
         @author_id = options['author_id']
    end

    def self.find_by_id(id)
        question = QuestionDBConnection.instance.execute(<<-SQL, id)
            SELECT
              *
            FROM 
              questions
            WHERE
              id = ?
        SQL
        return nil unless question.length > 0
        User.new(question.first)
    end

    def self.find_by_author_id(author_id)
        question = QuestionDBConnection.instance.execute(<<-SQL, author_id)
            SELECT
              *
            FROM 
              questions
            WHERE
              author_id = ?
        SQL
        question.map{|question| Question.new(question)}
    end

    

end

class QuestionFollow
    attr_accessor :id, :users_id, :questions_id
    def initialize(options)
         @id = options['id']
         @users_id = options['users_id']
         @questions_id = options['questions_id']
    end

    def self.find_by_id(id)
        questionFollow = QuestionDBConnection.instance.execute(<<-SQL, id)
            SELECT
              *
            FROM 
              question_follows
            WHERE
              id = ?
        SQL
        return nil unless questionFollow.length > 0
        User.new(questionFollow.first)
    end
end

class Reply
    attr_accessor :id, :question_ref_id,:user_ref_id,:body,:parent_reply_id

    def initialize(options)
         @id = options['id']
         @question_ref_id = options['question_ref_id']
         @user_ref_id = options['user_ref_id']
         @body = options['body']
         @parent_reply_id = options['parent_reply_id']
    end
    
    def self.find_by_id(id)
        reply = QuestionDBConnection.instance.execute(<<-SQL, id)
            SELECT
              *
            FROM 
              replies
            WHERE
              id = ?
        SQL
        return nil unless reply.length > 0
        User.new(reply.first)
    end
end

class QuestionLike
    attr_accessor :id, :likes,:user_like_ref_id ,:quesiton_like_ref_id

     def initialize(options)
         @id = options['id']
         @likes = options['likes']
         @user_like_ref_id= options['user_like_ref_id']
         @question_like_ref_id = options['question_like_ref_id']
    end

    def self.find_by_id(id)
         questionLike = QuestionDBConnection.instance.execute(<<-SQL, id)
            SELECT
              *
            FROM 
              question_likes
            WHERE
              id = ?
        SQL
        return nil unless questionLike.length > 0
        User.new(questionLike.first)
    end

end

