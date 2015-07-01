class TicketStatus < ActiveRecord::Base

	has_many :ticket_details, class_name: "TicketDetail", inverse_of: :ticket_status
	
	scope :inclusive, -> { includes(:ticket_details)}

	
end
