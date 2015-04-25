class Store::Detail < ActiveRecord::Base
  belongs_to :location
  has_one :manager, :through => :location
  has_many :people, class_name: "Person", foreign_key: "store_detail_id", inverse_of: :store_detail
  #has_many :employees, class_name: "Person", :through => :store_detail


  delegate :name, :to => :location, :allow_nil => true, :prefix => true
  delegate :name, :to => :manager, :allow_nil => true, :prefix => "manager"
  #### Won't work until managers are filled #### 
  #delegate :manager_id, :to => :location, :allow_nil => true, :prefix => true
  #### Equally this throws errors too:
  #delegate :name, :to => :'location.parent', :allow_nil => true, :prefix => "area"
  scope :inclusive, -> { includes(:location).includes(:manager)}
  scope :employees, -> { includes(:people)}

  #def employees
  #  Person.find_by(store_detail_id: self.id)
  #end

  def area
    begin
      self.location.parent
    rescue
      nil
    end
  end

  
  def manager_id
    #cannot use delegate atm because there are missing managers
    begin
      self.location.manager_id
    rescue
      0
    end
  end

end
