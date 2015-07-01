class CreateTicketPriorities < ActiveRecord::Migration
  def change
    create_table :ticket_priorities do |t|
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
