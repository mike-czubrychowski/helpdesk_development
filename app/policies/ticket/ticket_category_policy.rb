class TicketCategoryPolicy < ApplicationPolicy
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
      scope.inclusive.where("ticket_categories.id IN (?) OR  ticket_categories.id IN (?)", @current_user.organisation.ticket_category.subtree_ids, @current_user.organisation.ticket_category.sibling_ids)
    end
  end
end
