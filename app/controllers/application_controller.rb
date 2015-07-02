class ApplicationController < ActionController::Base
  
  
  protect_from_forgery with: :exception
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  after_filter :verify_authorized, unless: :devise_controller?
  #after_filter :verify_policy_scoped, only: :index


  private
    

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
    
end
