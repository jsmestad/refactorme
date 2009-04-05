class CalendarsController < ApplicationController
  
  def index
    @date = Date.today
    @snippets = Snippet.current_month.all
    respond_to do |wants|
      wants.html { }
      wants.atom { render :layout => false }
    end
  end
  
end