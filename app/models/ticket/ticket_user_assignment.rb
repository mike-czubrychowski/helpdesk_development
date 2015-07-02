class TicketUserAssignment < ActiveRecord::Base
  	belongs_to :ticket_detail,  inverse_of: :ticket_user_assignments
  	belongs_to :user, class_name: "User", foreign_key: "user_id"#, inverse_of: :cuntface
  	has_one :person, :through => :user

    accepts_nested_attributes_for :user, allow_destroy: false, :reject_if => :all_blank

    scope :inclusive, -> { includes(:ticket_detail).includes(:user).includes(:person)}

    has_paper_trail
    paginates_per 10

    validates_presence_of :user_id
    validates_presence_of :ticket_detail_id

	def user_name
		begin
		  self.user.person.name
		rescue
		  nil
		end
	end
end
