class StoreDetail < ActiveRecord::Base
  #belongs_to :storelocation
  
  #Not quite an alias of the above
  belongs_to :location, class_name: "Storelocation", foreign_key: "location_id", inverse_of: :store_detail
  
  has_one :manager, :through => :location
  has_many :employees, class_name: "Person", foreign_key: "store_detail_id", inverse_of: :store_detail
  has_many :store_tills, class_name: "StoreTill", :through => :location
  
  delegate :name, :to => :location, :allow_nil => true, :prefix => true
  delegate :name, :to => :manager, :allow_nil => true, :prefix => "manager"
  

  #### Won't work until managers are filled #### 
  #delegate :manager_id, :to => :location, :allow_nil => true, :prefix => true
  #### Equally this throws errors too:
  #delegate :name, :to => :'location.parent', :allow_nil => true, :prefix => "area"
  
  scope :inclusive, -> { includes(:location).includes(:manager).includes(:employees)} #.includes(:store_tills)
  scope :employees, -> { includes(:employees)}


  
  
  def manager_id
    #cannot use delegate atm because there are missing managers
    begin
      self.location.manager_id
    rescue
      0
    end
  end

  def tickets
    begin
      TicketDetail.where("location_id in (?)", self.location.subtree_ids)
    rescue 
      nil
    end
  end

  def employees
    begin
      self.location.manager.employees
    rescue 
      nil
    end   
  end

  def area
    begin
      self.ancestors.where(category: 'area').name
    rescue
      nil
    end
  end

end
