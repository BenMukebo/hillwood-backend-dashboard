class CreateMovieComments < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_comments do |t|
      t.text :text
      t.integer :likes_counter
      t.references :movie, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
