class CreateTicketStatusHistories < ActiveRecord::Migration
  def change
    create_table :ticket_status_histories do |t|
      t.references :ticket_detail, index: true
      t.references :ticket_status, index: true
      t.datetime :from
      t.datetime :to
      t.references :updated_by, index: true
      t.timestamps
    end
  end
end
