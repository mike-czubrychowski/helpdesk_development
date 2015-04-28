class CreateTicketUsers < ActiveRecord::Migration
  def change
    create_table :ticket_user_assignments do |t|
      t.references :ticket_detail, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
