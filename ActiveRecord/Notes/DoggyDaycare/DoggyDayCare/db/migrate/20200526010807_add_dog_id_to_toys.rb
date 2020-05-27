class AddDogIdToToys < ActiveRecord::Migration[6.0]
  def change
    add_column :toys, :dog_id, :integer, null: false 
  end
end
