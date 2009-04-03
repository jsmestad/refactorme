class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  
  def index
    @users = User.paginate :page => params[:page], :per_page => 30, :conditions => {:active => true}, :order => 'created_at DESC'
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.signup!(params)
      UserNotifier.send_later(:deliver_activation_instructions, @user)
      #@user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def show
    @user = User.find_by_login!(params[:id])
    @user_snippets = @user.snippets.latest.all
    @top_refactors = @user.refactors.top.all
  end

  # def edit
  #   @user = @current_user
  # end
  # 
  # def update
  #   @user = @current_user # makes our views "cleaner" and more consistent
  #   if @user.update_attributes(params[:user])
  #     flash[:notice] = "Account updated!"
  #     redirect_to account_url
  #   else
  #     render :action => :edit
  #   end
  # end
  
  # def destroy
  #   user = User.find!(params[:id])
  #   if user.destroy
  #     render :text => "User has been deleted"
  #   end
  # end
  
end
