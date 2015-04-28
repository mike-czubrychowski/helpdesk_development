class Ticket::UserAssignment < ActiveRecord::Base
  	belongs_to :ticket_detail, class_name: "Ticket::Detail", inverse_of: :ticket_user_assignments
  	belongs_to :user, class_name: "User", foreign_key: "user_id"#, inverse_of: :cuntface
  	
    accepts_nested_attributes_for :user, allow_destroy: false, :reject_if => :all_blank


	def user_name
		begin
		  self.user.person.name
		rescue
		  nil
		end
	end
end
