class CreateTagTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_topics do |t|
      t.integer :url_id
      t.string :topic
      t.timestamps
    end
  end
end
