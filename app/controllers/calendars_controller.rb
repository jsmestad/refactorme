class CalendarsController < ApplicationController
  
  def index
    @date = Date.today
    @calendar = Calendar.find_by_date(@date)
    respond_to do |wants|
      wants.html { render :action => 'show' }
      wants.atom do 
        @snippets = Snippet.latest.all
        render :layout => false
      end
    end
  end

  def show
    @date = Date.new(params[:year].to_i, params[:month].to_i)
    @calendar = Calendar.find_by_date(@date)
    respond_to do |wants|
      wants.js { render :text => render_to_string(:partial => 'calendar') }
      wants.html { render }
    end
  end
  
end
