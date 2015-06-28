module NamespacedAccessProtection
  extend ActiveSupport::Concern
 
  included do
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    helper_method :policy_for
  end
 
 
  protected
 
  def policy_scope(resources)
    @policy_scope = policy_scope_for(resources)
    super
  end
 
  def policy(resources)
    puts 'RESOURCES'
    puts resources
    self.policy= policy_for(resources)
    super
  end
 
 
 
  private
 
  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to root_path
  end
 
  def policy_for(resource)
    puts 'POLICY FOR-------'
    puts resource.name
    puts self.class.name
    puts pundit_user
    PolicyFinder.for_controller(resource, self).policy!.new(pundit_user, resource)
  end
 
  def policy_scope_for(resources)
    PolicyFinder.for_controller(resources, self).scope!.new(pundit_user, resources).resolve
  end
 
  class PolicyFinder < Pundit::PolicyFinder
    def self.for_controller(object, controller)
      puts 'controller'
      puts controller.class.parent.name #=Ticket
      puts object.name
      new(object, controller.class.parent)
    end
 
    def initialize(object, namespace)
      puts 'init'
      puts object.class.name
      puts namespace.class.name
      super(object)
      @namespace = namespace
    end
 
    attr_reader :namespace
 
    def policy
      puts 'now policy'
      super or parent_policy
    end
 
    def find
      #had to edit this to stop it looking for Ticket::Ticket::Detail
      if super.to_s.include? '::' then 
        super
      else
        "#{namespace}::#{super}"
      end
    end
 
    def parent_policy
      puts 'PARENT POLICY'
      puts namespace.class.name
      puts object.class.name
      return nil if namespace == Object
      PolicyFinder.new(object, namespace.parent).policy
    end
 
 
  end
  private_constant :PolicyFinder
end
