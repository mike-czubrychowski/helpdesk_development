class Storelocation < Location
	has_one :store_detail, class_name: "Store::Detail", inverse_of: :location
	has_many :store_tills, class_name: "Store::Till", inverse_of: :location

  #delegate :id, :to => :store_detail, :allow_nil => true, :prefix => "store"

  scope :inclusive, -> { includes(:manager).includes(:store_detail).includes(:store_tills)}
 
  def store_id
    begin
      self.store_detail.id     
    rescue 
      0
    end   
  end 

end
