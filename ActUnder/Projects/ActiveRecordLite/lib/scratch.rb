require '00_attr_accessor_object'

class Dan

    def initialize

        @a = "a"
        @b = "b"

    end


  def self.my_attr_accessor(*names)
    # ...

    names.each do |name|

      define_method("#{name}" + "=") do
        instance_variable_set("@" + "#{name}"
      end
    end

  end


end
