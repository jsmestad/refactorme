class CalendarsController < ApplicationController
  def index
    @date = Date.today
    @snippets = Snippet.all(:conditions => ["MONTH(displayed_on) = ?", Date.today.month], :order => 'displayed_on ASC')
  end
  
end