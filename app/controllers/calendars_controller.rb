class CalendarsController < ApplicationController
  
  def index
    @date = Date.today
    @calendar = Calendar.find_by_date(@date)
    respond_to do |wants|
      wants.html { render :action => 'show' }
      wants.atom { render :layout => false }
    end
  end

  def show
    @date = Date.new(params[:year].to_i, params[:month].to_i)
    @calendar = Calendar.find_by_date(@date)
  end
  
end
