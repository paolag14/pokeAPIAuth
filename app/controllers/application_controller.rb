# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
    include Authentication
    helper_method :current_user
    #before_action :destroy_all_active_sessions

    #def current_user
        # Logic to retrieve the current authenticated user, you can modify this based on your authentication implementation
     #   @current_user ||= active_session.find_by(id: session[:user_id])
    #end

    
end
  