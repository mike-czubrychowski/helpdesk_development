class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.references :store_detail, index: true
      t.foreign_key :store_details
      t.date :startdate
      t.date :leavedate
      t.integer :title
      t.string :firstname
      t.string :lastname
      t.string :preferredname
      t.string :jobtitle
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
