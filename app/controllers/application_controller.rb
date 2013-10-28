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
  
end