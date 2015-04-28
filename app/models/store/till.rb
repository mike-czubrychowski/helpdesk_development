class Store::Till < ActiveRecord::Base
  belongs_to :location,  class_name: "Storelocation", foreign_key: "location_id", inverse_of: :store_tills
end
