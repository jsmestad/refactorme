ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  map.display_snippet "/:year/:month/:day", :controller => "snippets", :action => "display", :requirements => { :year => /20\d{2}/, :month => /(0?[1-9]|1[12])/, :day => /(0?[1-9]|[12]\d|3[01])/ }
  
  map.resources :snippets, :member => { :approve => :put } do |snippet|
    snippet.resources :refactors, :member => { :send_to_gist => :get }, :has_many => [:votes]
  end
  
  # map.resources :refactors, :path_prefix => '/:year/:month/:day', :requirements => { :year => /20\d{2}/, :month => /(0?[1-9]|1[12])/, :day => /(0?[1-9]|[12]\d|3[01])/ } 
  
  map.submit_snippet "/submit", :controller => "snippets", :action => "new"
  
  map.resource :account, :controller => 'accounts'
  map.resources :users
  map.resources :password_resets, :as => 'forgot_password'
  map.resource :user_session, :as => 'session'
  
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  
  # User Activation
  map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
  map.activate '/activate/:id', :controller => 'activations', :action => 'create'
  
  map.rss_feed "/rss.xml", :controller => "calendars", :action => 'index', :format => 'rss'
  
  map.root :controller => "calendars", :action => "index"
  map.connect '*path', :controller => 'public', :action => 'show', :conditions => { :method => :get }
end
