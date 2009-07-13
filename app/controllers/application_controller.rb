class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher
  
  helper :all
  helper_method :warden, :authenticated?
  protect_from_forgery

  filter_parameter_logging :password, :password_confirmation

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  private
  
    #def current_user_session
      #return @current_user_session if defined?(@current_user_session)
      #@current_user_session = UserSession.find
    #end

    #def current_user
      #return @current_user if defined?(@current_user)
      #@current_user = current_user
    #end
    
    def require_admin
      unless current_user && current_user.is_admin?
        flash[:notice] = "You have insufficient privileges to access this page"
        redirect_to root_url
        return false
      end
    end

    def require_user
      debugger
      if current_user.nil?
        #store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      unless current_user.nil?
        #store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_url
        return false
      end
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def bad_request
      render :template => 'exceptions/400', :status => :bad_request
    end

    def not_found
      render :template => 'exceptions/404', :status => :not_found
    end
end
