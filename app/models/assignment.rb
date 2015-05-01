class Assignment < ActiveRecord::Base
  	belongs_to :user, :inverse_of => :assignment
	belongs_to :role, :inverse_of => :assignments
	
	
	validates :user_id, :presence => true, :uniqueness => true 
end
