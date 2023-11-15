class AddProfileDataToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile, :jsonb, null: false, default: '{}'
    add_column :users, :location, :jsonb,  null: false, default: '{}'
    add_column :users, :social_links, :jsonb
    # add_column :users, :status, :integer, default: 0, null: false, index: true

    add_index :users, :profile, using: :gin
    add_index :users, :location, using: :gin
    add_index :users, :social_links, using: :gin
  end
end
