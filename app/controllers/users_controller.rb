class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_admin, :only => [:index, :destroy]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    @user = User.find_by_login!(params[:id])
    @user_snippets = @user.snippets.find(:all, :conditions => ["displayed_on IS NOT NULL"], :limit => 5, :order => 'created_at DESC')
    @top_refactors = @user.refactors.find(:all, :joins => ["INNER JOIN votes ON votes.refactor_id = refactors.id"], :limit => 5, :order => "SUM(votes.score) DESC")
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