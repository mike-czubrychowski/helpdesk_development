class Ticket::Category < ActiveRecord::Base

	has_many :tickets, 			class_name: "Ticket::Detail",							  	inverse_of: :category
	has_many :subcategories, 	class_name: "Ticket::Subcategory",							inverse_of: :category
	
end
