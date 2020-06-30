def do_three_times(object, method_name)
  3.times { object.send(method_name) }
end

class Dog
  def bark
    puts "Woof"
  end

  def nani
    puts 2 + 2
  end

end

dog = Dog.new
do_three_times(dog, :nani)


class Cat
  def say(anything)
    puts anything
  end

  def method_missing(method_name)
    method_name = method_name.to_s
    if method_name.start_with?("say_")
      text = method_name[("say_".length)..-1]

      say(text)
    else
      # do the usual thing when a method is missing (i.e., raise an
      # error)
      super
    end
  end
end

earl = Cat.new
earl.say_hello # puts "hello"
earl.say_goodbye # puts "goodbye"