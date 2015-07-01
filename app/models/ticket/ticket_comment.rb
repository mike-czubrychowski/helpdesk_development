class TicketComment < ActiveRecord::Base
  
  belongs_to :ticket_detail, class_name: "TicketDetail",      foreign_key: "ticket_detail_id",   inverse_of: :ticket_comments				
  belongs_to :created_by, class_name: "User",            foreign_key: "created_by"#,  inverse_of: :comments
  #belongs_to :updated_by, class_name: "User",            foreign_key: "created_by",  #inverse_of: :comments
  has_one :person, :through => :created_by
  enum comment_type: {"reply" => 0, "comment" => 1, "resolution" => 2}

  scope :inclusive, -> { includes(:ticket_detail).includes(:created_by).includes(:person)}
end
