class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  has_many :assignments
  has_many :ticket_user_assignments, class_name: "Ticket:User", inverse_of: :user
  has_many :tickets, class_name: "Ticket::Detail", inverse_of: :created_by
  has_many :comments, class_name: "Ticket::Comment", inverse_of: :created_by
  has_many :roles, :through => :assignments #this could be has_one
  belongs_to :person, inverse_of: :user
  belongs_to :organisation, inverse_of: :users


  delegate :name, :to => :person, :allow_nil => true
  
  def has_role?(role_sym)
	 roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
end
