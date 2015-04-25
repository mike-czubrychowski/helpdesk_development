class Ticket::Status < ActiveRecord::Base

	has_many :tickets, 	class_name: "Ticket::Detail",							  	inverse_of: :status
end
