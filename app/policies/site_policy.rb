class SitePolicy < LocationPolicy

	
  class Scope < Scope
    def resolve
      scope
    end
  end
end