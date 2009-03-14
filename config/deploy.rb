# Please install the Engine Yard Capistrano gem
# gem install eycap --source http://gems.engineyard.com
require "eycap/recipes"

set :keep_releases, 5
set :application,   'refactorme'
set :repository,    'git@github.com:jsmestad/refactorme.git'
set :deploy_to,     "/data/#{application}"
set :deploy_via,    :export
set :monit_group,   "#{application}"
set :scm,           :git

# This is the same database name for all environments
set :production_database,'refactorme_production'

set :environment_host, 'localhost'
set :deploy_via, :remote_cache

# uncomment the following to have a database backup done before every migration
# before "deploy:migrate", "db:dump"

# comment out if it gives you trouble. newest net/ssh needs this set.
ssh_options[:paranoid] = false
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
default_run_options[:pty] = true # required for svn+ssh:// andf git:// sometimes

# This will execute the Git revision parsing on the *remote* server rather than locally
set :real_revision, 			lambda { source.query_revision(revision) { |cmd| capture(cmd) } }


task :Production do
  role :web, '75.101.167.152'
  role :app, '75.101.167.152'
  role :db, '75.101.167.152', :primary => true
  set :environment_database, Proc.new { production_database }
  set :dbuser,        'refactorme'
  set :dbpass,        '8oCRMbneY1'
  set :user,          'refactorme'
  set :password,      '8oCRMbneY1'
  set :runner,        'refactorme'
end


# TASKS
# Don't change unless you know what you are doing!
after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"
after "deploy:update_code","deploy:symlink_configs"


