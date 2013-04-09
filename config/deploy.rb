require "bundler/capistrano"
require 'capistrano-unicorn'

# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
set :rvm_ruby_string, '2.0.0@travel_mongrasse' 
set :rvm_type, :user

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'deploy:install_requirements'
before 'deploy:setup', 'rvm:install_ruby'
after 'deploy:setup', "deploy:set_rvm_version"

after 'deploy:restart', 'unicorn:reload' # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'  # app preloaded

load "config/recipes/base"
load "config/recipes/nginx"
# load "config/recipes/unicorn"
# load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/imagemagick"
# load "config/recipes/rbenv"
# load "config/recipes/check"
load "config/recipes/git"

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

# Apply default RVM version for the current account
# after "deploy:setup", "deploy:set_rvm_version"
namespace :deploy do
  task :set_rvm_version do
    run "source /etc/profile.d/rvm.sh && rvm use #{rvm_ruby_string} --default"
  end
  task :install_requirements do
    # sudo "rvm --autolibs=4 requirements #{rvm_ruby_string}"
    # run "#{sudo} apt-get -y --no-install-recommends install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion pkg-config libffi-dev"
    run "#{sudo} apt-get -y --no-install-recommends install make libreadline6-dev libyaml-dev libsqlite3-dev sqlite3 libxslt1-dev autoconf libgdbm-dev libncurses5-dev automake bison libffi-dev"
  end
  task :install_ruby do
    run "rvm --autolibs=1 install #{rvm_ruby_string}"
  end
end

after "deploy", "deploy:cleanup"

require "rvm/capistrano" 