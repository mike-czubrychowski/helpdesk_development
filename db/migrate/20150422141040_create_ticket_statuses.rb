class CreateTicketStatuses < ActiveRecord::Migration
  def change
    create_table :ticket_statuses do |t|
      t.string :name, index: true
      t.integer :order
      t.boolean :time_tracked

      t.timestamps
    end
  end
end
