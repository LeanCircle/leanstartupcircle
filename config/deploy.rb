require 'bundler/capistrano'
require 'capistrano-unicorn'

default_run_options[:pty] = true  # Must be set for the password prompt
set :ssh_options, {:forward_agent => true}

set :application, "leanstartupcircle"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, "git"
set :repository, "git@github.com:TriKro/leanstartupcircle.git"
set :branch, "master"

set :user, "root"             # The server's user for deploys

role :web, "173.255.215.243"          # Your HTTP server, Apache/etc
role :app, "173.255.215.243"          # Unicorn

after 'deploy:restart', 'unicorn:reload'  # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart' # app preloaded
after 'deploy:update_code', 'deploy:symlink_db'
after 'deploy:update_code', 'deploy:config_nginx'
after 'deploy:update_code', 'deploy:symlink_wiki'

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Symlink the wiki"
  task :symlink_wiki, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/db/wiki #{release_path}/db/wiki"
  end

  desc "Configure nginx after a deploy"
  task :config_nginx, :roles => :app do
    run "rm /etc/nginx/sites-available/lsc"
    run "ln -nfs #{deploy_to}/current/config/leanstartupcircle.com.nginx.conf /etc/nginx/sites-available/lsc"

    run "service nginx restart"
  end
end
