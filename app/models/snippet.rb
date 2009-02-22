class Snippet < ActiveRecord::Base
  acts_as_list
  
  belongs_to :user
  has_many :refactors
  
  def self.set_daily_snippet
    todays = Snippet.first(:conditions => 'displayed_on IS NULL AND position IS NOT NULL', :order => 'position')
    if todays.remove_from_list
      todays.update_attribute :displayed_on, Date.today
    else
      Exception.new("Error running rake set_todays_snippet at #{Time.now}, remove_from_list returned false.")
    end
  end
  
  def approve!
    add_to_list
  end
  
  def reject!
    return self.destroy ? true : false
  end
  
end
