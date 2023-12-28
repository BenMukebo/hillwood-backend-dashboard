class CreateMovieOutcasts < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_outcasts do |t|
      t.string :avatar_url
      t.string :first_name
      t.string :last_name
      t.jsonb :personal_details, null: false, default: { address: nil, bio: nil, date_of_birth: nil, first_name: nil, last_name: nil, sex: nil, interests: nil, languages: nil }
      t.integer :status

      t.timestamps
    end

    add_index :movie_outcasts, :personal_details, using: :gin
  end
end
