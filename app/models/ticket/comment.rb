class Ticket::Comment < ActiveRecord::Base
  
  belongs_to :ticket, class_name: "Ticket::Detail",      foreign_key: "ticket_detail_id",    								inverse_of: :comments				
  belongs_to :created_by, class_name: "User",            foreign_key: "created_by"#,  inverse_of: :comments
  #belongs_to :updated_by, class_name: "User",            foreign_key: "created_by",  #inverse_of: :comments

  enum comment_type: {"reply" => 0, "comment" => 1, "resolution" => 2}
end
