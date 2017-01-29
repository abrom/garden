# config valid only for current version of Capistrano
lock '3.7.1'

set :application, 'Garden Plants'
set :repo_url, 'git@github.com:abrom/garden.git'
set :deploy_to, '/home/garden/garden'

set :scm, :git
set :branch, 'master'
set :user, 'garden'
set :group, 'garden'
set :rails_env, 'production'
set :keep_releases, 3

set :conditionally_migrate, true
set :keep_assets, 2
