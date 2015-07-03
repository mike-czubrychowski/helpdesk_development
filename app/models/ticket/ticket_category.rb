class TicketCategory < ActiveRecord::Base

	has_many :ticket_details, inverse_of: :ticket_category
  has_many :organisations,  inverse_of: :ticket_category
  has_one :ticket_statistic, inverse_of: :ticket_category

  

	scope :inclusive, -> { includes(:ticket_details)}

  has_ancestry
  has_paper_trail
  paginates_per 10

  validates_length_of :name, maximum: 50
  validates_presence_of :name


  def tickets
  	begin
  		TicketDetail.where("ticket_category_id IN (?)", self.subtree_ids)
  	rescue 
  		nil
  	end
  end
	
end
