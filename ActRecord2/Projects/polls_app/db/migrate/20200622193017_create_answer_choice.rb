class CreateAnswerChoice < ActiveRecord::Migration[6.0]
  def change
    create_table :answer_choices do |t|
      t.integer :q_id, null: false
      t.string :a_body, null: false
    end

    add_index :answer_choices, :q_id
  end
end
