class CreateOutcasts < ActiveRecord::Migration[7.0]
  def change
    create_table :outcasts do |t|
      t.string :avatar_url
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.jsonb :personal_details, null: false, default: {
        address: nil, bio: nil, email: nil, sex: nil, interests: nil, languages: nil
      }
      t.integer :status

      t.timestamps
    end

    add_index :outcasts, :personal_details, using: :gin
  end
end
