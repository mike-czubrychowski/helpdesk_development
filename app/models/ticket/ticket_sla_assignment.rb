class TicketSlaAssignment < ActiveRecord::Base

  #self.primary_keys = :ticket_category_id, :ticket_priority_id, :ticket_type_id

  belongs_to :ticket_category
  belongs_to :ticket_priority
  belongs_to :ticket_type
  belongs_to :ticket_sla, inverse_of: :ticket_sla_assignments


  validates_presence_of :ticket_category_id
  validates_presence_of :ticket_priority_id
  validates_presence_of :ticket_type_id
  validates_presence_of :ticket_sla_id
  validates_presence_of :name
  validates_length_of :name, maximum: 50
  validates_presence_of :order
  validates_numericality_of :order, :only_integer, :greater_than => 0

  
  #has_many :ticket_details, :class_name => 'TicketDetail', :foreign_key => [:ticket_category_id, :ticket_priority_id, :ticket_type_id]
end
