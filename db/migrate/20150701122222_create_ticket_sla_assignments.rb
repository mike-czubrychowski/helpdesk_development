class CreateTicketSlaAssignments < ActiveRecord::Migration
  def change
    create_table :ticket_sla_assignments do |t|
      t.string :name
      t.integer :order
      t.references :ticket_category, index: true
      t.references :ticket_priority, index: true
      t.references :ticket_type, index: true
      t.references :ticket_sla, index: true

      t.timestamps
    end
  end
end
