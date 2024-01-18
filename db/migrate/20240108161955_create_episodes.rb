class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.string :name
      t.text :description
      t.string :image_url
      t.date :released_at
      t.time :duration
      t.integer :status
      t.references :video_link, foreign_key: { to_table: :videos }
      t.references :trailer_link,  foreign_key: { to_table: :videos }
      t.references :season, null: false, foreign_key: true
      t.references :serie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
