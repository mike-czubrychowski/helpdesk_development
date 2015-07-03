class TicketStatistic < ActiveRecord::Base
  belongs_to :ticket_category, inverse_of: :ticket_statistic

  delegate :name, :to => :ticket_category, :allow_nil => true, :prefix => true

  scope :inclusive, -> { includes(:ticket_category)}
end
