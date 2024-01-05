class AddProfileDataToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile, :jsonb, null: false, default: { 
      avatar_url: nil,  bio: nil, date_of_birth: nil, first_name: nil, last_name: nil, interests: '[]', languages: '[]', phone_verified: false, sex: nil
    }
    add_column :users, :location, :jsonb,  null: false, default: { country: nil, state: nil, city: nil, zip_code: nil, address: '' }
    add_column :users, :social_links, :jsonb,  null: false, default: { facebook: nil, instagram: nil, linkedin: nil, twitter: nil, youtube: nil}
    add_column :users, :verification_status, :integer, index: true # , default: 0, null: false

    add_index :users, :profile, using: :gin
    add_index :users, :location, using: :gin
    add_index :users, :social_links, using: :gin
  end
end
