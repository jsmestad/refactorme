# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] = "test" 
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'
require 'cucumber/formatters/unicode'

require 'webrat'
require 'factory_girl'
require File.expand_path(File.join( RAILS_ROOT, "spec", "factories"))
Dir[ File.join(Rails.root, "spec", "lib", "*.rb") ].each { |f| require f }

Cucumber::Rails.use_transactional_fixtures
 
Webrat.configure do |config|
  config.mode = :rails
end

# Comment out the next two lines if you're not using RSpec's matchers (should / should_not) in your steps.
require 'cucumber/rails/rspec'
require 'webrat/rspec-rails'
