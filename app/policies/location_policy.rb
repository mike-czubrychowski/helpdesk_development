class LocationPolicy < ApplicationPolicy

  def index? ; true; end 
	def show?   ; user.location.subtree_ids.include? record.id; end
  def create? ; false; end
  def update? ; false; end
  def destroy?; false; end

  class Scope < Scope
    def resolve
      scope.where("id IN (?)", user.location.subtree_ids)
    end
  end
end