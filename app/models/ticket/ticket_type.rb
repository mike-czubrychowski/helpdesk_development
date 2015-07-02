class TicketType < ActiveRecord::Base

	has_many :ticket_details,	inverse_of: :ticket_type
	
	scope :inclusive, -> { includes(:ticket_details)}

	has_paper_trail
    paginates_per 10

    validates_presence_of :name
    validates_length_of :name, maximum: 50
    validates_presence_of :order
    validates_numericality_of :order, :only_integer, :greater_than => 0

	def tickets
	  	begin
	  		TicketDetail.where("ticket_type_id =?", self.id)
	  	rescue 
	  		nil
	  	end
	end
end
