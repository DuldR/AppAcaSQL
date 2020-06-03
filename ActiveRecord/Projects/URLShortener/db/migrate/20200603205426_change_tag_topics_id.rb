class ChangeTagTopicsId < ActiveRecord::Migration[6.0]
  def change
    remove_column :tag_topics, :url_id
  end
end
