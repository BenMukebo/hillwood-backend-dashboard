class CreateSeries < ActiveRecord::Migration[7.0]
  def change
    create_table :series do |t|
      t.string :name
      t.text :description
      t.integer :category
      t.string :image_url
      t.jsonb :content_details, null: false, default: {
        country: nil, original_language: nil
      }
      t.integer :status, null: false
      t.references :movie_genre, null: false, foreign_key: true
      t.references :video_link, foreign_key:  { to_table: :videos }
      t.references :movie_writter, foreign_key: true
      t.references :movie_outcast, foreign_key: true

      t.timestamps
    end

    add_index :series, :name, unique: true
    add_index :series, :content_details, using: :gin
  end
end
