class Ticket::Category < ActiveRecord::Base

	has_many :ticket_details, 			class_name: "Ticket::Detail",			  	inverse_of: :category
	has_many :ticket_subcategories, 	class_name: "Ticket::Subcategory",			inverse_of: :ticket_category
  has_many :organisations, class_name: "Organisation", inverse_of: :ticket_category


	scope :inclusive, -> { includes(:ticket_details).includes(:ticket_category)}

  def tickets
  	begin
  		Ticket::Detail.where("ticket_category_id = ?", self.id)
  	rescue 
  		nil
  	end
  end
	
end
