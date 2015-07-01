class TicketType < ActiveRecord::Base


	has_many :ticket_details, class_name: "TicketDetail", inverse_of: :ticket_type
	
	scope :inclusive, -> { includes(:ticket_details)}

	def tickets
	  	begin
	  		TicketDetail.where("ticket_type_id =?", self.id)
	  	rescue 
	  		nil
	  	end
	 end
end
