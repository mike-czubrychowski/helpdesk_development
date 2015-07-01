class TicketPriority < ActiveRecord::Base


	has_many :ticket_details, class_name: "TicketDetail", inverse_of: :ticket_priority
	
	scope :inclusive, -> { includes(:ticket_details)}

	def tickets
	  	begin
	  		TicketDetail.where("ticket_priority_id =?", self.id)
	  	rescue 
	  		nil
	  	end
	end

end
