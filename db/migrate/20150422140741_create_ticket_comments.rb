class CreateTicketComments < ActiveRecord::Migration
  def change
    create_table :ticket_comments do |t|
      t.references :ticket_detail, index: true
      t.foreign_key :ticket_details
      t.string :name
      t.text :description
      t.integer :comment_type
      t.references :created_by, index: true
     
      t.references :updated_by, index: true
      
      t.timestamps
    end
  end
end
