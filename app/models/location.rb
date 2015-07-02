class Location < ActiveRecord::Base

  enum category_id: {"Area" => 21, "Country" => 51, "Division" => 41, "Global Region" => 800, "Site" => 11, "Region" => 31, "Company" => 999, "Store" => 5} 

  belongs_to :manager,  class_name: "Person"
 

  has_many :ticket_details, class_name: "TicketDetail", inverse_of: :location
  has_many :ticket_comments, class_name: "TicketComment", through: :ticket_details
  has_many :ticket_statuses, class_name: "TicketStatus", through: :ticket_details
  has_many :ticket_categories, class_name: "TicketCategory", through: :ticket_details
  has_many :organisations, inverse_of: :location
  has_many :users, inverse_of: :location

  scope :inclusive, -> {includes(:manager).includes(:ticket_details).includes(:ticket_statuses).includes(:ticket_categories)}#includes(:ticket_comments)
  scope :opentickets, -> {includes(:ticket_details)}

  has_paper_trail
  paginates_per 50


  delegate :name, :to => :manager, :allow_nil => true, :prefix => true
  delegate :name, :to => :ticket_categories, :allow_nil => true, :prefix => true
  delegate :name, :to => :ticket_statuses, :allow_nil => true, :prefix => true


  ###### STI ###############################################################
  has_ancestry

  self.inheritance_column = :category

  def self.categories
  	%w(World Globalregion Country Division Region Area Site Storelocation)
  end 

  #########################################################################

  validates_associated :manager

  def parent_name
    begin
      Location.find(self.parent.id).name
    rescue 
      nil
    end
  end

  def manager_name
    #only necessary because some managers are nil
    begin
      Person.find(self.manager.id).name
    rescue 
      nil
    end
  end


  def friendly_name
    begin
      if self.manager.nil? or self.category == 'Storelocation' then
        self.name
      else
        self.manager.friendly_name
      end
    rescue 
      nil
    end
  end

  def tickets
    begin
      TicketDetail.where("location_id in (?)", self.subtree_ids)
    rescue 
      nil
    end
  end

  def employees
    begin
       self.manager.employees
     rescue 
       nil
     end 
  end


  

  

    
end











  
