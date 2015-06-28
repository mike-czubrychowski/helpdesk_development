class ApplicationPolicy

  #This is required because the line in config.rb to autoload policy scripts doesn't fully work for some reason
  extend ActiveSupport::Autoload
  autoload :Tickets
  
  attr_reader :current_user, :record

  def initialize(current_user, model)
    @current_user = current_user
    @record = model
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(current_user, record.class)
  end

  class Scope
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
