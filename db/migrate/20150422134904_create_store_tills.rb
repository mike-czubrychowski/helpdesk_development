class CreateStoreTills < ActiveRecord::Migration
  def change
    create_table :store_tills do |t|
      t.string :name
      t.references :location, index: true
      t.integer :modelname
      t.string :ip
      t.integer :comms_support
      t.integer :mid
      t.integer :ped_user
      t.integer :ped_pin
      t.string :pos_keyboard

      t.timestamps
    end
  end
end
