class CalendarsController < ApplicationController
  
  caches_page :index
  
  def index
    @date = Date.today
    @snippets = Snippet.current_month.all()
  end
  
end