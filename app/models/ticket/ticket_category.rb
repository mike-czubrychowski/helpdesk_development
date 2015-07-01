class TicketCategory < ActiveRecord::Base

	has_many :ticket_details, class_name: "TicketDetail", inverse_of: :ticket_category
	#has_many :ticket_subcategories, 	class_name: "TicketSubcategory",			inverse_of: :ticket_category
  has_many :organisations, class_name: "Organisation", inverse_of: :ticket_category

  has_ancestry


	scope :inclusive, -> { includes(:ticket_details)}

  def tickets
  	begin
  		TicketDetail.where("ticket_category_id IN (?)", self.subtree_ids)
  	rescue 
  		nil
  	end
  end
	
end
