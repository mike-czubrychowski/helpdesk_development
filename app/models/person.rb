class Person < ActiveRecord::Base
  
  belongs_to :store_detail, inverse_of: :employees, class_name: "Store::Detail"

  has_one :user,            inverse_of: :person
  delegate :name, :to => :store_detail, :allow_nil => true, :prefix => "store"

  #alias_method :subordinates, :employees

  scope :inclusive, -> {includes(:store_detail)}

  def name
    begin
    	if self.preferredname.nil? then
      		self.firstname.split(" ")[0] + ' ' + self.lastname
      	else
      		self.preferredname + ' ' + self.lastname
      	end
    rescue
      nil
    end
  end

  def friendly_name
    begin
      if self.preferredname.nil? then
          self.firstname.split(" ")[0] + self.lastname[0]
        else
          self.preferredname + self.lastname[0]
        end
    rescue
      nil
    end
  end

  def location
    begin
      if self.is_manager? then
        Location.find_by(manager_id: self.id)
      else
        Location.find(self.store_detail.location_id)
      end
    rescue 
      nil
    end
    
  end
   
  def is_manager?
    Location.exists?(:manager_id => self.id)
  end

  def manager
    begin
      if self.is_manager? then
        #Location.find_by(manager_id: self.id)
        Person.find(self.location.parent.manager)
      else
        Person.find(self.store_detail.location.manager.id)
      end
    rescue 
      nil
    end
    
  end

  def sublocations
    begin
      Store::Detail.where("location_id IN (?)", self.location.subtree_ids)
    rescue 
      nil
    end
  end

  def employees
    begin
      Person.where("store_detail_id IN (?)", self.sublocations.map{|id| id.id})
    rescue 
      nil
    end
    
  end


  
end
