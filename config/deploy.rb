require "bundler/capistrano"
# require "capistrano-rbenv"
# set :rbenv_ruby_version, "2.0.0-p0"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/imagemagick"
# load "config/recipes/rbenv"
# load "config/recipes/check"
# load "config/recipes/git"

server "192.34.57.66", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "travel_mongrasse"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, :production

set :scm, "git"
set :repository, "git@github.com:bartezic/travel.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup"

set :rvm_ruby_string, :local               # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"        # more info: rvm help autolibs

before 'deploy:setup', 'rvm:install_rvm'   # install RVM
before 'deploy:setup', 'rvm:install_ruby'  # install Ruby and create gemset, OR:
before 'deploy:setup', 'rvm:create_gemset' # only create gemset

require "rvm/capistrano"