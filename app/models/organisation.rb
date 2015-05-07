class Organisation < ActiveRecord::Base

	has_many :users, inverse_of: :organisation
	belongs_to :ticket_category, inverse_of: :organisations, class_name: "Ticket::Category"
	belongs_to :location, inverse_of: :organisations
end
