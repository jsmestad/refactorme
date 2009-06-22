class SessionsController < ApplicationController
  before_filter :require_user, :only => [:destroy]
  before_filter :require_no_user, :only => [:new, :create, :unauthenticated]

  def new
    render
  end

  def create
    authenticate!(params)
    if logged_in?
      flash[:notice] = "You have logged in successfully."
      redirect_to root_path
    else
      flash[:error] = "Try Again."
      render :action => 'new'
    end
  end

  def destroy
    logout
    if logged_in?
      flash[:error] = "logout failed"
    end
    redirect_to root_path
  end

  def unauthenticated 
    render :text => "#{request.env['warden.errors'].full_messages}"
  end

end
