
	class Ticket::DetailPolicy < Ticket::ApplicationPolicy
	  def index? ; true; end 
	  def show?   ; false; end #return true if @current_user.tickets.include? @record.id; false; end
	  def create? ; false; end
	  def update? 
	  	puts 'HELLO DO YOU READ ME'
	  	puts @current_user.role.name
	  	case @current_user.role.name.to_sym
	  		
		  	when :superadmin
		  		return true
		  	when :admin
		  		return true if @current_user.location.subtree_ids.include? @record.location_id
		  	when :helpdesk
		  		return true if @current_user.tickets.include? @record or @current_user.location.subtree_ids.include? @record.location_id 
		  	else
		  		return false
	  	end

	  	false
	  end

	  def destroy?; false; end

	  class Scope < Scope

	    #is this needed or is it inherited from Applciation Policy
	    attr_reader :current_user, :scope

	    def initialize(current_user, scope)
	      @current_user = current_user
	      @scope = scope
	    end

	    def resolve
	      scope.where("ticket_details.location_id IN (?) ", @current_user.location.subtree_ids)
	    end
	  end
	end

	class DetailPolicy < Ticket::ApplicationPolicy
	  #This does nothing apart from prevent an unable to autoload constant error
	end

	

	


