class Organisation < ActiveRecord::Base

	has_many :users, inverse_of :organisation
end
