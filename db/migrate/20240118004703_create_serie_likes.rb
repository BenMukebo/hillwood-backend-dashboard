class CreateSerieLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :serie_likes do |t|
      t.references :serie, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
