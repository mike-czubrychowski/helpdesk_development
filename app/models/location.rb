class Location < ActiveRecord::Base
  
  has_ancestry

  
  

  belongs_to :manager,  class_name: "Person"
  has_many :tickets,     class_name: "Ticket::Detail",                        inverse_of: :location

  enum category_id: {"Area" => 21, "Country" => 51, "Division" => 41, "Global Region" => 800, "Site" => 11, "Region" => 31, "Company" => 999, "Store " => 5}

  #delegate :name, :to => :parent, :allow_nil => true, :prefix => true
  delegate :name, :to => :manager, :allow_nil => true, :prefix => true

  scope :inclusive, -> { includes(:manager)}
  scope :opentickets, -> {includes(:subtree).includes(:tickets)}

  self.inheritance_column = :category

  def self.categories
  	%w(World Globalregion Country Division Region Area Site Storelocation)
  end 

  

    
end











  
