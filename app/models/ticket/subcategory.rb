class Ticket::Subcategory < ActiveRecord::Base

  belongs_to :category,			class_name: "Ticket::Category",	foreign_key: "ticket_category_id", 	inverse_of: :subcategory
  has_many 	 :tickets, 			class_name: "Ticket::Detail",	inverse_of: :subcategory

end
