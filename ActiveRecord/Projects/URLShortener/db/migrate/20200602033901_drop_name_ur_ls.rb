class DropNameUrLs < ActiveRecord::Migration[6.0]
  def change
    remove_column :shortened_urls, :name
    add_column :shortened_urls, :user_id, :integer
  end
end
