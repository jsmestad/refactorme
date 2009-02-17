require 'fileutils'
require 'active_record'

namespace :integrity do
  desc "integrity setup and runner"
  task :test do
    FileUtils.cp "#{RAILS_ROOT}/config/database.yml.sample", "#{RAILS_ROOT}/config/database.yml"
  end
end