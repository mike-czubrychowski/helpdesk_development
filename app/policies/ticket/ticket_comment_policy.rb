class TicketCommentPolicy < ApplicationPolicy

  def index?  
    true
  end 
  def show?   ; self.index? end 
  def create? ; self.index? end
  def update? ; self.index? end
  def destroy?; self.index? end

  class Scope < Scope

    #is this needed or is it inherited from Applciation Policy
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      scope.where("ticket_detail_id IN (?) ", @current_user.tickets.map { |t| t.id})
    end
  end
end
