class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.integer :category
      t.string :image_url
      t.date :released_at
      t.jsonb :content_details, null: false, default: {
        country: nil, duration: nil, original_language: nil
      }
      t.integer :views, default: 0, null: false
      t.integer :likes_counter, default: 0, null: false
      t.integer :comments_counter, default: 0, null: false
      t.integer :status, null: false
      t.references :movie_genre, null: false, foreign_key: true
      t.references :video_link, foreign_key: { to_table: :videos }
      t.references :trailer_link,  foreign_key: { to_table: :videos }
      t.references :movie_writter, foreign_key: true

      t.timestamps
    end

    add_index :movies, :name, unique: true
    add_index :movies, :content_details, using: :gin 
  end
end
