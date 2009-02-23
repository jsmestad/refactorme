set :application, "refactorme"
 
# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/jsmestad/sites/refactorme"
 
# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :repository, "git@sneezy.insyntax.com:refactor_me.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :rails_env, "production" 
set :keep_releases, 5
 
set :user, 'jsmestad'
#set :ssh_options, { :forward_agent => true }
 
role :app, "refactorme.com"
role :web, "refactorme.com"
role :db,  "refactorme.com", :primary => true
 
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  task :symlink_configs, :roles => :app, :except => { :no_symlink => true } do
    run <<-CMD
      cd #{release_path} &&
      ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml
    CMD
  end
  
  task :migrate, :roles => :db do
    run "cd #{release_path}; rake RAILS_ENV=#{rails_env} db:migrate"
  end
  
  desc "Gem Tasks"
  task :gems, :roles => :app do
    run "cd #{release_path}; rake RAILS_ENV=#{rails_env} gems:install"
  end
end

after "deploy", "deploy:cleanup", "deploy:symlink_configs", "deploy:gems", "deploy:migrate"