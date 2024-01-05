class CreateSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :seasons do |t|
      t.string :title, null: false, index: true
      t.text :description
      t.string :image_url
      t.integer :status, null: false
      t.references :video_link, foreign_key: { to_table: :videos }
      t.integer :episods_counter
      t.references :serie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
