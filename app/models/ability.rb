class Ability
  include CanCan::Ability

  def initialize(user)#, controller_namespace)
    # Define abilities for the passed in user here. For example:
    user ||= User.new 

    can :manage, :all

    #can see tickets they created
    #tickets they are assigned to
    
    cannot :manage, [   Location, Person, User] 
    #                    Store::Detail.all, Store::Till.all,
    #                    Ticket::Detail.all, Ticket::Comment.all, 
    #                    Ticket::StatusHistory.all, Ticket::UserAssignment.all,
    #                    Ticket::Category.all, Ticket::Subcategory.all, Ticket::Status.all]
    
    #Down with revisionist history
    cannot [:edit], Ticket::Comment.all
    
    

    case user.role
     when "superadmin"
        #do all
        can :manage, :all
     when "helpdesk"
        #see all
        can [:read, :index, :show], [Location, Person, User]

     when "thirdparty"
        #tickets in Categories they can see
        can [:read, :index, :show], [Location, Person, Store, User]
        
     when "employee"
       
        #tickets, people, locations in their location
        #can :manage, Location.where("id =9")
        can :index, Location
        can :manage, Location.where("id IN (?)", user.location.subtree_ids) do |location|
            can [:read, :index, :show], Location, :id => location.id
        end

        #can :manage, [Ticket::Detail.all, ]
        #can :manage, Location.all#, user.location.subtree_ids)
        

        can :manage, Person, ["store_detail_id = 598"] do |person|
            person.store_detail_id == 598
        end
        #can [:read, :edit], Ticket::Detail.where("location_id = 93")
        #cannot :index, Ticket::Detail.all
        #.where("store_detail_id IN (?)", user.sublocations.map{|id| id.id})
       #joins(:store_detail).where("store_detail.location_id IN (?)", user.location.subtree_ids)
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
