class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  has_one :assignment
  has_many :ticket_user_assignments, class_name: "TicketUserAssignment", inverse_of: :user
  
  has_many :ticket_details, class_name: "TicketDetail", inverse_of: :created_by, foreign_key: "created_by_id"
  has_many :ticket_comments, class_name: "TicketComment", inverse_of: :created_by, foreign_key: "created_by_id"
  
  has_one :role, :through => :assignment #this could be has_one
  has_one :store_detail, :through => :person 
  
  belongs_to :person, inverse_of: :user
  belongs_to :organisation, inverse_of: :users
  belongs_to :location, inverse_of: :users


  scope :inclusive, -> {includes(:person).includes(:store_detail).includes(:location).includes(:ticket_details).includes(:ticket_comments).includes(:role).includes(:organisation).includes(:ticket_user_assignments)}

  has_paper_trail
  paginates_per 50

  delegate :name, :to => :person, :allow_nil => true
  delegate :name, :to => :role, :allow_nil => true, :prefix => true
  delegate :name, :to => :location, :allow_nil => true, :prefix => true
  
  def has_role?(role_sym)
    #not working
	 roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  
  def tickets
    begin
      self.ticket_details
    rescue 
      nil
    end
  end

  def default_category
    begin
      self.organisation.ticket_category
    rescue 
      nil
    end
  end
  
end
