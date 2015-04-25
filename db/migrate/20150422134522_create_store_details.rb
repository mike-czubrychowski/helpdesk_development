class CreateStoreDetails < ActiveRecord::Migration
  def change
    create_table :store_details do |t|
      t.string :name
      t.references :location, index: true
      t.string :account, limit: 3
      t.string :status, null: false
      t.date :openingday, null: false
      t.string :address1, null: false
      t.string :address2
      t.string :address3
      t.string :town, null: false
      t.string :county
      t.string :postcode, null: false
      t.string :phone
      t.string :uk_country, null: false
      t.boolean :centreofexcellence, default: 0
      t.boolean :superleague, default: 0
      t.float :latitude, default: 0
      t.float :longitude, default: 0

      t.timestamps
    end
  end
end
