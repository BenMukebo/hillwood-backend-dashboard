class CreateMovieGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_genres do |t|
      t.string :name

      t.timestamps
    end

    add_index :movie_genres, :name, unique: true
  end
end
