class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.text :description
      t.integer :category
      t.string :photo_url
      t.date :released_date
      t.integer :songs_counter
      t.jsonb :content_details, null: false, default: {}
      t.integer :status
      # t.references :artist, null: false, foreign_key: true
      t.string :video_link, foreign_key: { to_table: :videos }

      t.timestamps
    end
    add_index :albums, :content_details, using: :gin
  end
end
