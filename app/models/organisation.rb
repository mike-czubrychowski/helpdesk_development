class Organisation < ActiveRecord::Base

	has_many :users, inverse_of: :organisation
	belongs_to :ticket_category, inverse_of: :organisations, class_name: "TicketCategory"
	belongs_to :location, inverse_of: :organisations

	def ticket_catergories
	    begin
	      self.ticket_category
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
