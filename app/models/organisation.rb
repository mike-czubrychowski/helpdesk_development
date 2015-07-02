class Organisation < ActiveRecord::Base

	has_many :users, inverse_of: :organisation
	belongs_to :ticket_category, inverse_of: :organisations, class_name: "TicketCategory"
	belongs_to :location, inverse_of: :organisations

	scope :inclusive, -> {includes(:users).includes(:ticket_category).includes(:location)}

	has_paper_trail
    paginates_per 10

    validates_presence_of :ticket_category_id
	validates_presence_of :location

	validates_length_of :name, maximum: 50
    validates_presence_of :name


	def ticket_catergories
	    begin
	      self.ticket_category.subtree
	    rescue 
	      nil
	    end
	end

	def tickets
	    begin
	      self.ticket_details.where("ticket_category_id in (?)", self.ticket_catergories.subtree_ids)
	    rescue 
	      nil
	    end
	end

	def users
		begin
			self.users
		rescue 
			nil
		end
		
	end


end
