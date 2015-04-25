class CreateTicketSubcategories < ActiveRecord::Migration
  def change
    create_table :ticket_subcategories do |t|
      t.references :ticket_category, index: true
      t.string :name

      t.timestamps
    end
  end
end
