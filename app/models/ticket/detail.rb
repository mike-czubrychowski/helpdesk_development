class Ticket::Detail < ActiveRecord::Base


  belongs_to :location,																  				inverse_of: :ticket_details
  belongs_to :parent,   				class_name: "Ticket::Detail",                             	inverse_of: :children
  has_many 	 :children,   			class_name: "Ticket::Detail",       foreign_key: "parent_id", 	inverse_of: :parent  
  belongs_to :ticket_category, 				 class_name: "Ticket::Category",     foreign_key: "ticket_category_id", 							  	inverse_of: :ticket_details	
  belongs_to :ticket_subcategory, 		 class_name: "Ticket::Subcategory",  foreign_key: "ticket_subcategory_id",  							inverse_of: :ticket_details
  belongs_to :ticket_status, 					 class_name: "Ticket::Status",       foreign_key: "ticket_status_id", 								inverse_of: :tickets
  has_many   :comments, 				       class_name: "Ticket::Comment",  foreign_key: "ticket_detail_id", 			inverse_of: :ticket
  belongs_to :created_by,				       class_name: "User",                 foreign_key: "created_by",  inverse_of: :tickets
 
  has_many   :ticket_user_assignments, class_name: "Ticket::UserAssignment",   foreign_key: "ticket_detail_id",   inverse_of: :ticket_detail 
  has_many	 :users, class_name: "User", 				:through => :ticket_user_assignments
  

  accepts_nested_attributes_for :comments, allow_destroy: true
  accepts_nested_attributes_for :ticket_user_assignments, allow_destroy: true
  accepts_nested_attributes_for :users, allow_destroy: false

  enum ticket_priority: {"low" => 0, "normal" => 1, "high" => 2, "critical" => 3}
  enum ticket_type: {"issue" => 0, "incident" => 1, "complaint" => 2, "bug" => 4, "knowledge" => 4}

  delegate :name, :to => :ticket_category, :allow_nil => true, :prefix => "ticket_category"
  delegate :name, :to => :ticket_subcategory, :allow_nil => true, :prefix => "ticket_subcategory" #not working
  delegate :name, :to => :ticket_status, :allow_nil => true, :prefix => "ticket_status"
  delegate :name, :to => :location, :allow_nil => true, :prefix => true
  delegate :name, :to => :parent, :allow_nil => true, :prefix => true

  scope :inclusive, -> { includes(:ticket_subcategory).includes(:ticket_category).includes(:ticket_status).includes(:location)}
  

  

  def created_by_name
    begin
      #not working
      self.created_by.person.name
    rescue
      nil
    end
  end

 

end
