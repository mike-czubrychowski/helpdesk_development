class Ticket::StatusPolicy < Ticket::ApplicationPolicy
  def index? ; true; end 
  def show?   ; true; end 
  def create? ; true; end
  def update? ; true;  end
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

class StatusPolicy < Ticket::ApplicationPolicy
  #This does nothing apart from prevent an unable to autoload constant error
end

	