class AttrAccessorObject
  def self.my_attr_accessor(*names)

    names.each do |name|
      define_method(name) do
        instance_variable_get("@#{name}")
      end

      #You pass an argument to the new defined method using the pipes.
      define_method("#{name}" + "=") do |arg|
        instance_variable_set("@#{name}", arg)
      end
    end
  end
end
