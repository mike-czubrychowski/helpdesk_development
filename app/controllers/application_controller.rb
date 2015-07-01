class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :set_lookups, only: [:edit, :update, :new]
  after_filter :verify_authorized, unless: :devise_controller?
  #after_filter :verify_policy_scoped, only: :index


  #def current_ability
    #Regd for namespaced models
   # controller_name_segments = params[:controller].split('/')
   # controller_name_segments.pop
   # controller_namespace = controller_name_segments.join('/').camelize
   # Ability.new(current_user, controller_namespace)
  #end

  #@locations = Location.all
  #@ticket_status_histories = TicketStatusHistory.inclusive
  private
    def set_lookups
      @ticket_categories = policy_scope(TicketCategory)
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
    
end
