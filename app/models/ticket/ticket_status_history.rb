class TicketStatusHistory < ActiveRecord::Base

	belongs_to :ticket_detail, class_name: "TicketDetail", foreign_key: "ticket_detail_id", inverse_of: :ticket_status_histories
	belongs_to :ticket_status, class_name: "TicketStatus", foreign_key: "ticket_status_id"
	belongs_to :updated_by, class_name: "User", foreign_key: "updated_by_id"

	delegate :name, :to => :ticket_status, :allow_nil => true, :prefix => "ticket_status"
	delegate :name, :to => :ticket_detail, :allow_nil => true, :prefix => "ticket_detail"

	scope :inclusive, -> { includes(:ticket_detail).includes(:ticket_status)}

	after_create :send_notification_email

	def send_notification_email
		user = User.first
		StatusHistoryMailer.post_email(user).deliver
	end
  
  
end
