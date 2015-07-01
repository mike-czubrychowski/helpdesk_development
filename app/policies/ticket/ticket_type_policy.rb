class TicketTypePolicy < ApplicationPolicy
  def index? ; true; end 
  def show?   ; true; end 
  def create? 
    return true if @current_user.role.name.to_sym == :superadmin 
    false
  end
  def update? ; self.create?;  end
  def destroy?; self.create?; end

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

