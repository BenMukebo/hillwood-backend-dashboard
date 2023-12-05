class AddProfileDataToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile, :jsonb, null: false, default: '{}'
    add_column :users, :location, :jsonb,  null: false, default: '{}'
    add_column :users, :social_links, :jsonb
    add_column :users, :verification_status, :integer, index: true # , default: 0, null: false

    add_index :users, :profile, using: :gin
    add_index :users, :location, using: :gin
    add_index :users, :social_links, using: :gin
  end
end
