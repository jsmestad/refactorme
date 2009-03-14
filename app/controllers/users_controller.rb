class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_admin, :only => [:index, :destroy]
  
  def index
    @users = User.paginate :page => params[:page], :per_page => 12, :conditions => {:active => true}
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.signup!(params)
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def show
    @user = User.find_by_login!(params[:id])
    @user_snippets = @user.snippets.find(:all, :conditions => ["displayed_on IS NOT NULL"], :limit => 5, :order => 'created_at DESC')
    @top_refactors = @user.refactors.find(:all, :limit => 5, :order => "(SELECT SUM(votes.score) FROM votes WHERE votes.refactor_id = refactors.id) DESC")
  end

  def edit
    if @current_user.is_admin?
      @user = User.find_by_login!(params[:id])
    else
      @user = @current_user
    end
  end

  def update
    if @current_user.is_admin?
      @user = User.find_by_login!(params[:id])
    else
      @user = @current_user # makes our views "cleaner" and more consistent
    end
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  def destroy
    user = User.find_by_login!(params[:id])
    if user.destroy
      render :text => "User has been deleted"
    end
  end
  
end