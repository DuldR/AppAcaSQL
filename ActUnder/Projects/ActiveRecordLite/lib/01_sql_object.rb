require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject


  def self.columns
    # ...

    @columns ||= DBConnection.execute2(<<-SQL)[0].map { |str| str.to_sym }
      SELECT
        *
      FROM
        cats
    SQL

  end

  def self.finalize!

    SQLObject.columns.each do |method|
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

    @table_name || self.name.downcase.pluralize

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
    values = self.class.columns.map { |item| self.send(item) }
  end

  def insert
    # ...


    print attribute_values
    # col_names = self.class.columns.join(", ")
    # question_marks = (["?"] * self.class.columns.length).join(", ")

    # print col_names
    # print question_marks
    # print *attribute_values

    # DBConnection.execute(<<-SQL, "Gizmo", 1)

    # INSERT INTO
    #   "#{self.class.table_name}" (*attribute_values)
    # VALUES
    #   (#{question_marks})
    # SQL


  end

  def update
    # ...
  end

  def save
    # ...
  end

  SQLObject.finalize!
end
