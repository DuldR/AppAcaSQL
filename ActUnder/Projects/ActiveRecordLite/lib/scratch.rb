class Human < SQLObject
  self.table_name = 'humans'

end






c = Cat.new(name: "Gizmo", owner_id: 123)