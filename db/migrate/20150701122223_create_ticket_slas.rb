class CreateTicketSlas < ActiveRecord::Migration
  def change
    create_table :ticket_slas do |t|
      t.string :name
      t.float :breach, default: 1, null: false
      t.float :warn, default: 0.66667, null: false

      t.timestamps
    end
  end
end
