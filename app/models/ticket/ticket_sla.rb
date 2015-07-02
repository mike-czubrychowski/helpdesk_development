class TicketSla < ActiveRecord::Base

  
  has_many :ticket_details, inverse_of: :ticket_sla
  has_many :ticket_sla_assignments, inverse_of: :ticket_sla

  scope :inclusive, -> { includes(:ticket_details)}
  
  has_paper_trail
  paginates_per 10

  validates_length_of :name, maximum: 50
  validates_presence_of :name
  validates_presence_of :breach
  validates_presence_of :warn

  validates_length_of :name, maximum: 255
  validates_numericality_of :breach, greater_than: 0, less_than: 5 #hard code a sensible number of days
  validates_numericality_of :warn, greater_than: 0, less_than: :breach
  

end
