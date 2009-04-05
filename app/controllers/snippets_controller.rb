class SnippetsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  before_filter :require_admin, :except => [:display, :new, :create]
  
  def display
    date = Date.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}")
    @snippet = Snippet.find_by_displayed_on!(date)
    @refactors = @snippet.refactors.paginate :include => [:user], :page => params[:page], :order => 'created_at', :per_page => 6
  end

  def index
    @snippets = Snippet.paginate :page => params[:page], :per_page => 12, :conditions => ['displayed_on IS NULL'], :order => 'created_at'
  end

  # Admin Functionality - for main site, see display method
  def show
    @snippet = Snippet.find_by_id!(params[:id])
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(params[:snippet])
    @snippet.user = current_user # Set Author as current user
    
    if @snippet.save
      flash[:success] = "Snippet submitted for review"
      redirect_to root_url
    else
      render :action => :new
    end
  end
  
  def edit
    @snippet = Snippet.find_by_id!(params[:id])
  end
  
  def update
    @snippet = Snippet.find_by_id!(params[:id])
    
    @snippet.user.deliver_approved_snippet_notification!(@snippet) if params[:approved] == "true"

    if @snippet.update_attributes(params[:snippet])
      flash[:success] = "Snippet has been updated"
      redirect_to @snippet
    else
      render :action => :edit
    end
  end
  
  def destroy
    snippet = Snippet.find_by_id!(params[:id])
    respond_to do |wants|
      if snippet.destroy
        wants.js { render :text => 'Removed successfully' }
      else
        wants.js { render :text => 'Deletion totally failed.' }
      end
    end
  end
  
  def approve
    snippet = Snippet.find(params[:id])
    snippet.approve! if params[:approved] == "true"
    respond_to do |wants|
      wants.js { render :text => "#{snippet.position}" }
    end
  end
  
end