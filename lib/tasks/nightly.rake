desc "Grab the snippet at top of queue and set as active"
task :set_todays_snippet => :environment do
  include HoptoadNotifier::Catcher
  
  begin
    todays = Snippet.first(:conditions => 'displayed_on IS NULL AND position IS NOT NULL', :order => 'position')
    if todays.remove_from_list
      todays.update_attribute :displayed_on, Date.today
    else
      Exception.new("Error running rake set_todays_snippet at #{Time.now}, remove_from_list returned false.")
    end
  rescue Exception => e
    notify_hoptoad e
    puts e
  end
end