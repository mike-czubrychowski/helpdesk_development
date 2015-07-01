class TicketStatusHistoryPolicy < ApplicationPolicy
  def index? ; true; end 
  def show?   ; true; end 
  def create? ; true; end
  def update? ; true;  end
  def destroy?; false; end

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

