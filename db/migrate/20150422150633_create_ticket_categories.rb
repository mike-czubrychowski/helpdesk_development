class CreateTicketCategories < ActiveRecord::Migration
  def change
    create_table :ticket_categories do |t|
      t.string :name
      t.string :ancestry, :string, index: true
      t.timestamps
    end
  end
end
