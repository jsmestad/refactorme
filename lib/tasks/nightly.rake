desc "Grab the snippet at top of queue and set as active"
namespace :admin do
  task :set_daily_snippet => :environment do
    include HoptoadNotifier::Catcher
  
    begin
      Snippet.set_daily_snippet
      ActionController::Base::expire_page(:controller => "calendars", :action => "index")
    rescue Exception => e
      notify_hoptoad e
      puts e
    end
  end
end