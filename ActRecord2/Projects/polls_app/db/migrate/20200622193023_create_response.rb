class CreateResponse < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.integer :answer_id, null: false
      t.integer :question_id, null: false
      t.integer :user_id, null: false
    end

    add_index :responses, :answer_id
    add_index :responses, :question_id
    add_index :responses, :user_id

  end
end
