class TicketSlaAssignment < ActiveRecord::Base

  #self.primary_keys = :ticket_category_id, :ticket_priority_id, :ticket_type_id

  belongs_to :ticket_category
  belongs_to :ticket_priority
  belongs_to :ticket_type
  belongs_to :ticket_sla, inverse_of: :ticket_sla_assignments

  #has_many :ticket_details, :class_name => 'TicketDetail', :foreign_key => [:ticket_category_id, :ticket_priority_id, :ticket_type_id]
end
