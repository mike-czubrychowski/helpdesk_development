class TicketSla < ActiveRecord::Base

  
  has_many :ticket_details, inverse_of: :ticket_sla
  has_many :ticket_sla_assignments, inverse_of: :ticket_sla
  

end
