desc "Grab the snippet at top of queue and set as active"
namespace :admin do
  task :set_daily_snippet => :environment do
    include HoptoadNotifier::Catcher
  
    begin
      if Snippet.find(:all, :conditions => ['displayed_on = ?', Date.today]).empty?
        Snippet.set_daily_snippet
      end
    rescue Exception => e
      notify_hoptoad e
      puts e
    end
  end
end