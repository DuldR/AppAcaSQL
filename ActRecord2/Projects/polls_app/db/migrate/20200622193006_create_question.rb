class CreateQuestion < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :poll_id, null: false
      t.string :q_body, null: false
      t.timestamps
    end

    add_index :questions, :poll_id
  end
end
