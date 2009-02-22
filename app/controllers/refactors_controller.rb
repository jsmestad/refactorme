class RefactorsController < ApplicationController
  before_filter :require_user
  before_filter :require_admin, :only => [:destroy]
  
  before_filter :fetch_snippet
  
  def new
    @refactor = @snippet.refactors.new
  end
  
  def create
    @refactor = @snippet.refactors.build(params[:refactor])
    @refactor.user = current_user # Set User As Author
    if @refactor.save
      flash[:success] = "Refactor posted successfully."
      redirect_to @snippet
    else
      render :action => :new
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    refactor = Refactor.find(params[:id])
    if refactor.destroy
      flash[:success] = "Refactor deleted."
    end
    redirect_to @snippet
  end
  
  private
    
    def fetch_snippet
      @snippet = Snippet.find(params[:snippet_id])
    end
end