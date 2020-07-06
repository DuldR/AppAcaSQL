class Cat

  def self.make_self(param)
    self.new(param)
  end

  def initialize(params = {})

    @name = params[:name]
    @owner_id = params[:owner_id]
  end


end






c = Cat.new(name: "Gizmo", owner_id: 123)