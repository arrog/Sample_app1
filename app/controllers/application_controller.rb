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
  
  rescue_from Exception, :with => :render_error
      rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
      rescue_from ActionController::RoutingError, :with => :render_not_found
      rescue_from ActionController::UnknownController, :with => :render_not_found
      rescue_from ActionController::UnknownAction, :with => :render_not_found
      
      private

      def render_not_found(exception)
        render :template => "/errors/404.html.erb", :status => 404
      end

      def render_error(exception)
        render :template => "/errors/500.html.erb", :status => 500
      end
end