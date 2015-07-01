class TicketUserAssignmentPolicy < ApplicationPolicy

  
  def index? ; true; end 
  def show?   ; true; end 
  def create? 
    
    case @current_user.role.name.to_sym
      
      when :superadmin
        #All tickets
        return true
      when :admin, :helpdesk, :thirdparty
    
        #In your country
        return true if @record.ticket_detail.update?
      when :operations
        #Your location and below
        return false
    end

    return true if @current_user.tickets.include? @record

    false 
  end
  def update? ; self.create?;  end
  def destroy?; true; end

  class Scope < Scope

    #is this needed or is it inherited from Applciation Policy
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

