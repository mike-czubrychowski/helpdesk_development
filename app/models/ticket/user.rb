class Ticket::User < ActiveRecord::Base
  belongs_to :ticket, class_name: "Ticket:Detail"
  belongs_to :user, inverse_of: :ticket_user_assignments
end
