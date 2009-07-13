class SessionsController < ApplicationController
  before_filter :authenticate,  :only => [:create, :destroy]

  def new
    render
  end

  def create
    authenticate
    if logged_in?
      flash[:notice] = "You have logged in successfully."
      redirect_to root_path
    else
      flash[:error] = "Try Again."
      render :action => 'new'
    end
  end

  def unauthenticated
    flash[:error] = "Authentication Required"
    render :new
  end

  def destroy
    logout
    if logged_in?
      flash[:error] = "logout failed"
    end
    redirect_to root_path
  end

end
