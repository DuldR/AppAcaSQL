require 'active_support/inflector'
class Dan

  attr_accessor :attributes



  def self.meth
    @attributes = {}

    column = [:name, :id]
    column.each do |method|
      define_method(method) do
        @attributes[method]
      end

      define_method("#{method}" + "=") do |arg|
        @attributes[method] = arg
      end
    end

  end


end
