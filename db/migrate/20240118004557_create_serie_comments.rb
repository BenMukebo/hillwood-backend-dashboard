class CreateSerieComments < ActiveRecord::Migration[7.0]
  def change
    create_table :serie_comments do |t|
      t.text :text
      t.integer :likes_counter
      t.references :serie, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
