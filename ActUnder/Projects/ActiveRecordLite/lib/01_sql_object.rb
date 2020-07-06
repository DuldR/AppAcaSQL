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

  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
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
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end

  SQLObject.finalize!
end
