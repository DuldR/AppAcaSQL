class AddTimeStampsUrl < ActiveRecord::Migration[6.0]
  def change
    add_column :shortened_urls, :created_at, :datetime, null: false
    add_column :shortened_urls, :updated_at, :datetime, null: false
  end
end
