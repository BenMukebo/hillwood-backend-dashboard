class CreateAlbumsArtistsJoinTale < ActiveRecord::Migration[7.0]
  def change
    create_table :albums_artists_join_tales do |t|
      t.references :album, null: false, foreign_key: true
      t.references :artists, null: false, foreign_key: true

      t.timestamps
    end

    # add_index :albums_artists, [:album_id, :artist_id], unique: true
  end
end
