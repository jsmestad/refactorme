class SnippetsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  before_filter :require_admin, :except => [:display, :new, :create]
  
  def display
    date = Date.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}")
    @snippet = Snippet.find_by_displayed_on!(date)
  end

  def index
    @snippets = Snippet.all(:conditions => ['displayed_on IS NULL'])
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
    
    if @snippet.update_attributes(params[:snippet])
      flash[:success] = "Snippet has been updated"
      redirect_to @snippet
    else
      render :action => :edit
    end
  end
  
  def destroy
    snippet = Snippet.find_by_id!(params[:id])
    
    if snippet.destroy
      flash[:success] = "Snippet has been deleted"
    else
      flash[:error] = "Error while deleting snippet"
    end
    redirect_to snippets_path
  end
  
end