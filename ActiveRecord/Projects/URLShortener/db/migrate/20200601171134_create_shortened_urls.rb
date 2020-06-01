class CreateShortenedUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :shortened_urls do |t|
      t.string :name
      t.string :short_url
      t.string :long_url
    end

    add_index(:shortened_urls, :long_url)
  end
end
