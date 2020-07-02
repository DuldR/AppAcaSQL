require 'active_support/inflector'
class Dan

  attr_accessor :table

  def self.repeat
    @table = self
    @table.to_s.titleize.downcase.pluralize
  end

  def self.access(name)
    @table = name
    @table
  end

end
