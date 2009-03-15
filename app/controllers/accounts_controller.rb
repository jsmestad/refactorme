class AccountsController < ApplicationController
  before_filter :require_user, :only => [:edit, :update]

  def show
    redirect_to user_path(@user)
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => 'edit'
    end
  end
  
end
