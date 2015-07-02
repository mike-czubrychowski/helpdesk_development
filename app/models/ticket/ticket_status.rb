class TicketStatus < ActiveRecord::Base

	has_many :ticket_details, inverse_of: :ticket_status
	
	scope :inclusive, -> { includes(:ticket_details)}

	has_paper_trail
    paginates_per 10

    validates_presence_of :name
    validates_presence_of :time_tracked
    validates_presence_of :order
    validates_length_of :name, maximum: 50
    validates_numericality_of :time_tracked, :only_integer, :less_than_or_equal_to => 1, :greater_than_or_equal_to => 0
    validates_numericality_of :order, :only_integer, :greater_than => 0
    
	def tickets
	  	begin
	  		TicketDetail.where("ticket_status_id =?", self.id)
	  	rescue 
	  		nil
	  	end
	end
	
end
