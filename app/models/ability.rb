class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new 

    can :manage, :all

    #can see tickets they created
    #tickets they are assigned to
    
    #cannot :manage, [Location, Ticket, Person, Store::Detail]

    case user.role
     when "superadmin"
        #do all
     when "helpdesk"
        #see all
        can :manage, [Location, Ticket, Person, Store::Detail]
     when "thirdparty"
        #tickets in Categories they can see
       
     when "employee"
       
        #tickets, people, locations in their location
        can :manage, Location.where("id IN (?)", user.location.subtree_ids)
        can :manage, Store::Detail.where("location_id IN (?)", user.location.subtree_ids)
        can :manage, Ticket.where("location_id IN (?)", user.location.subtree_ids)
        can :manage, Person.where("store_detail_id IN (?)", user.sublocations.map{|id| id.id})
       
     when "customer"
        
    end
        
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
