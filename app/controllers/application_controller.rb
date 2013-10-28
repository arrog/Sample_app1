class ApplicationController < ActionController::Base
  
  protect_from_forgery
  after_filter :store_location

  # Force signout to prevent CSRF attacks

  def handle_unverified_request
    sign_out
    super
  end
  
  
  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end
  
  unless Rails.application.config.consider_all_requests_local
      rescue_from ActiveRecord::RecordNotFound,
                  ActionController::RoutingError,
                  ActionController::UnknownController,
                  ActionController::UnknownAction,
                  ActionController::MethodNotAllowed do |exception|

        # Put loggers here, if desired.

        redirect_to faq_path
      end
    end
  
end