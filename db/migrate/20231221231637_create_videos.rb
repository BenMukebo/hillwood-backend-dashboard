class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :url, null: false
      t.string :title
      t.integer :status
      t.jsonb :details, null: false, default: { duration: nil, dimention: nil, definition: nil, caption: nil, mime_type: nil }

      t.timestamps
    end

    add_index :videos, :details, using: :gin
  end
end
