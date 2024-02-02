class CreateOutcastAssociations < ActiveRecord::Migration[7.0]
  def change
    create_table :outcast_associations do |t|
      t.references :outcast, null: false, foreign_key: true
      t.references :media_association, polymorphic: true, null: false
      t.integer :role, null: false

      t.timestamps
    end
  end
end
