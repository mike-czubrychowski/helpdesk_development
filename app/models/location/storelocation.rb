class Storelocation < Location
	has_one :store_detail, class_name: "Store::Detail"
	has_many :store_tills, class_name: "Store::Till"

  #delegate :id, :to => :store_detail, :allow_nil => true, :prefix => "store"

  def store_id
    begin
      self.store_detail.id     
    rescue 
      0
    end   
  end 

end
