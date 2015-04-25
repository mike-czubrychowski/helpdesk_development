class Person < ActiveRecord::Base
  belongs_to :store_detail, inverse_of: :people, class_name: "Store::Detail"

  has_one :user,            inverse_of: :person

  delegate :name, :to => :store_detail, :allow_nil => true, :prefix => "store"

  def name
    begin
    	if self.preferredname.nil? then
      		self.firstname + ' ' + self.lastname
      	else
      		self.preferredname + ' ' + self.lastname
      	end
    rescue
      nil
    end
  end

  def location
    if self.manager? then
      Location.find_by(manager_id: self.id)
    else
      Location.find(self.store_detail.location_id)
    end
  end
   
  def manager?
    Location.exists?(:manager_id => self.id)
  end

  def subordinates
    Person.where("store_detail_id IN (?)", self.sublocations.map{|id|})

  end

  def sublocations
    Store::Detail.where("location_id IN (?)", self.location.subtree_ids)
  end

  
end
