class TicketStatisticPolicy < ApplicationPolicy
  def index? ; true; end 
  def show?   ; true; end 
  def create? ; false; end 
  def update? ; false; end 
  def destroy?; false; end 

  class Scope < Scope
    def resolve
      scope.inclusive.where("ticket_category_id IN (?)", @current_user.organisation.ticket_category.subtree_ids)
    end
  end
end
