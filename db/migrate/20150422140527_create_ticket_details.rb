class CreateTicketDetails < ActiveRecord::Migration
  def change
    create_table :ticket_details do |t|
      t.references :location, index: true, null: false
      t.foreign_key :locations
      t.references :parent, index: true
      t.references :ticket_type, default: 0
      t.references :ticket_category, index: true
      t.references :ticket_priority, default: 1
      t.references :ticket_status, index: true
      t.references :ticket_comment, index: true
      t.references :ticket_sla, index: true, default: 1
      t.string :name, null: false
      t.text :description
      t.references :created_by, index: true, null: false
      
      t.timestamps
    end
  end
end
