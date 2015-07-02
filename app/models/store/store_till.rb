class StoreTill < ActiveRecord::Base
  belongs_to :location,  class_name: "Storelocation", foreign_key: "location_id", inverse_of: :store_tills

  has_paper_trail
  paginates_per 50
end
