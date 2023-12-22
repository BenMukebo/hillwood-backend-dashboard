class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :url
      t.string :mime_type
      t.integer :status, null: false

      t.timestamps
    end
  end
end
