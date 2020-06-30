require '00_attr_accessor_object'

class Dan < AttAccessorObject

    def initialize

        @a = "a"
        @b = "b"

    end


  def self.my_attr_accessor(*names)
    # ...

    define_method(names) do
      instance_variable_get(names)
      instance_variable_set(names)
    end

  end
end
