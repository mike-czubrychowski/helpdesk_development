class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.references :parent, index: true,  null: false
      t.string :category,  null: false
      t.integer :category_id, null: false
      t.references :manager, index: true, unique: true
      t.string :ancestry, index: true

      t.timestamps
    end
  end
end
