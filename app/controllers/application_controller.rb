class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher
  
  #### REMOVE WHEN LIVE
  # USER_NAME, PASSWORD = "betas", "testing"
  # if RAILS_ENV == "production"
  #   before_filter :authenticate
  # end
  #### REMOVE WHEN LIVE
  
  helper :all
  protect_from_forgery

  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  private
  
    #### REMOVE WHEN LIVE
    # def authenticate
    #   authenticate_or_request_with_http_basic do |user_name, password|
    #     user_name == USER_NAME && password == PASSWORD
    #   end
    # end
    #### REMOVE WHEN LIVE
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_admin
      unless current_user && current_user.is_admin?
        flash[:notice] = "You have insufficient privileges to access this page"
        redirect_to root_url
        return false
      end
    end

    def require_user
      unless current_user
        #store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        #store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
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
