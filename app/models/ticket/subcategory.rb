class Ticket::Subcategory < ActiveRecord::Base

  belongs_to :ticket_category,	class_name: "Ticket::Category",	foreign_key: "ticket_category_id", 	inverse_of: :ticket_subcategories
  has_many 	 :ticket_details,   class_name: "Ticket::Detail",	inverse_of: :subcategory

  scope :inclusive, -> { includes(:ticket_details).includes(:ticket_category)}

  def tickets
  	begin
  		Ticket::Detail.where("ticket_subcategory_id = ?", self.id)
  	rescue 
  		nil
  	end
  end
end
