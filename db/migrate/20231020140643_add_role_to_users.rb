class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :role, null: false, foreign_key: true, index: true
  end
end
