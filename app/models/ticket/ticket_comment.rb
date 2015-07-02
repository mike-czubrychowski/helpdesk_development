class TicketComment < ActiveRecord::Base
  
  belongs_to :ticket_detail, inverse_of: :ticket_comments				
  belongs_to :created_by, class_name: "User",            foreign_key: "created_by",  inverse_of: :ticket_comments
  #belongs_to :updated_by, class_name: "User",            foreign_key: "created_by",  #inverse_of: :comments
  has_one :person, :through => :created_by
  
  scope :inclusive, -> { includes(:ticket_detail).includes(:created_by).includes(:person)}

  has_paper_trail
  paginates_per 50

  validates_presence_of :ticket_detail_id
  validates_presence_of :created_by_id

  validates_length_of :name, maximum: 255


end
