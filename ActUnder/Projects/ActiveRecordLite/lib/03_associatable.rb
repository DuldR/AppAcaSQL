require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...

    @class_name.constantize

  end

  def table_name
    # ...
    @class_name.downcase + "s"
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...

    name = name.singularize



    #self.class_name = name.camelize
    #self.foreign_key = "#{name}_id".to_sym

    if options[:foreign_key].nil?
      @foreign_key = "#{name}_id".to_sym
    else
      @foreign_key = options[:foreign_key]
    end

    if options[:class_name].nil?
      @class_name = name.camelize
    else
      @class_name = options[:class_name]
    end

    if options[:primary_key].nil?
      @primary_key = :id
    else
      @primary_key = options[:primary_key]
    end

  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...

    name = name.singularize
    self_class_name = self_class_name.singularize.downcase


    if options[:foreign_key].nil?
      @foreign_key = "#{self_class_name}_id".to_sym
    else
      @foreign_key = options[:foreign_key]
    end

    if options[:class_name].nil?
      @class_name = name.camelize
    else
      @class_name = options[:class_name]
    end

    if options[:primary_key].nil?
      @primary_key = :id
    else
      @primary_key = options[:primary_key]
    end
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...

  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
