class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.integer :name, null: false

      t.timestamps
    end

    add_index :roles, :name
  end
end
