class LocationPolicy < ApplicationPolicy

  def index? ; true; end 
	def show?   ; return true if @current_user.location.subtree_ids.include? @record.id; false; end
  def create? ; false; end
  def update? ; false; end
  def destroy?; false; end

  class Scope < Scope

    #is this needed or is it inherited from Applciation Policy
    attr_reader :user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      scope.where("id IN (?)", @current_user.location.subtree_ids)
    end
  end
end