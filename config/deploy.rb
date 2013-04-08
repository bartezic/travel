# set :application, "set your application name here"
# set :repository,  "set your repository location here"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

require "bundler/capistrano"


# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
set :rvm_ruby_string, '2.0.0@travel_mongrasse' 
set :rvm_type, :user

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

load "config/recipes/base"
# load "config/recipes/nginx"
# load "config/recipes/unicorn"
# load "config/recipes/postgresql"
# load "config/recipes/nodejs"
# load "config/recipes/imagemagick"
# load "config/recipes/rbenv"
# load "config/recipes/check"
# load "config/recipes/git"

server "192.34.57.66", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "travel_mongrasse"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:bartezic/travel.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# after "deploy:assets:precompile", "deploy:restart_workers"
# after "deploy:restart_workers", "deploy:restart_scheduler"

# def run_remote_rake(rake_cmd)
#   rake_args = ENV['RAKE_ARGS'].to_s.split(',')
#   cmd = "cd #{fetch(:latest_release)} && #{fetch(:rake, "rake")} RAILS_ENV=#{fetch(:rails_env, "production")} #{rake_cmd}"
#   cmd += "['#{rake_args.join("','")}']" unless rake_args.empty?
#   run cmd
#   set :rakefile, nil if exists?(:rakefile)
# end

# namespace :deploy do
#   desc "Restart Resque Workers"
#   task :restart_workers, :roles => :db do
#     run_remote_rake "resque:restart_workers"
#   end

#   desc "Restart Resque scheduler"
#   task :restart_scheduler, :roles => :db do
#      run_remote_rake "resque:restart_scheduler"
#   end
# end

after "deploy", "deploy:cleanup" # keep only the last 5 releases

require "rvm/capistrano"  