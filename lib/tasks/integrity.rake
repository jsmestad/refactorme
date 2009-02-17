require 'fileutils'

namespace :integrity do
  desc "integrity setup and runner"
  task :test do
    FileUtils.cp "#{RAILS_ROOT}/config/database.yml.sample", "#{RAILS_ROOT}/config/database.yml"
    # 
    # Rake::Task[ "db:drop" ].execute
    Rake::Task[ "db:create"].execute
    Rake::Task[ "db:migrate" ].execute
    Rake::Task[ "spec" ].execute
    Rake::Task[ "features" ].execute
  end
end