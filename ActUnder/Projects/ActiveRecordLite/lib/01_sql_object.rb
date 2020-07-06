require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject


  def self.columns
    # ...
    # https://www.youtube.com/watch?v=P-3GOo_nWoc
    # I explicitly call out the god damn cats table like an idiot.
    # This was a problem.

    @columns ||= DBConnection.execute2(<<-SQL)[0].map { |str| str.to_sym }
      SELECT
        *
      FROM
        #{self.table_name}
        
    SQL

  end


  def self.finalize!

    self.columns.each do |method|
      define_method(method) do
        self.attributes[method]
      end

      define_method("#{method}" + "=") do |arg|
        self.attributes[method] = arg
      end
    end

  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    # p self.to_s.downcase + "s"

    @table_name ||= self.name.downcase.pluralize

  end

  def self.all
    # ...

    data = DBConnection.execute(<<-SQL)
      SELECT
        "#{self.table_name}".*
      FROM
        "#{self.table_name}"
      SQL

    
    parse_all(data)
    

  end


  #This can be refactored
  def self.parse_all(results)
    # ...
    obj_arr = []
    results.each do |item|
      obj_arr << self.new(item)
    end

    obj_arr

  end

  def self.find(id)
    # ...


    data = DBConnection.execute(<<-SQL, id)
      SELECT
        "#{self.table_name}".*
      FROM
        "#{self.table_name}"
      WHERE
        "#{self.table_name}".id = ?
    SQL

    if data[0].nil?
      return nil
    else
      self.new(data[0])
    end

  end

  def initialize(params = {})
    # ...

    params.each do |k,v|
      check_sym = k.to_sym
      if self.class.columns.include?(check_sym)
        self.send("#{check_sym}=", v)
      else
        raise ArgumentError.new("unknown attribute '#{k}'")
      end
    end


  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
    self.class.columns.map { |item| self.send(item) }
  end

  def insert
    # ...


    col_names = self.class.columns.join(", ")
    question_marks = (["?"] * self.class.columns.length).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values)

    INSERT INTO
      "#{self.class.table_name}" (#{col_names})
    VALUES
      (#{question_marks})
    SQL

    self.send("id=", DBConnection.last_insert_row_id)

  end

  def update
    # ...

    set_line = self.class.columns.map { |item| "#{item} = ?" }.join(", ")
  
    # DBConnection.execute(<<-SQL, *attribute_values)

    #   UPDATE
    #     "#{self.class.table_name}"
    #   SET
    #     (#{set_line})
    #   WHERE
    #     id = ?


    # SQL

    DBConnection.execute(<<-SQL, *attribute_values, self.id)

      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL

  end

  def save
    # ...
  end

end
