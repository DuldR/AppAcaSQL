class ChangeResponseColumnName < ActiveRecord::Migration[6.0]
  def change
    remove_column :responses, :question_id
  end
end
