class Ticket::StatusHistory < ActiveRecord::Base
  belongs_to :detail
  belongs_to :status
  belongs_to :updated_by
end
