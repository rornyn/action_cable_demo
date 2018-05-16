# config valid for current version and patch releases of Capistrano
lock "~> 3.10.2"

server '192.168.1.219', roles: [:web, :app, :db], primary: true
set :application, "action_cable"
set :repo_url, "git@github.com:shailjasingh/action_cable_demo.git"
set :user, 'ubox55'


# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/ubox55/projects/remote/action_cable"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache


set :puma_conf, "#{shared_path}/config/puma.rb"



# # Default value for :linked_files is []
# set :linked_files, ["config/database.yml", "config/secrets.yml"]
#
# # Default value for linked_dirs is []
# set :linked_dirs, ["log", "tmp", "public"]

## Linked Files & Directories (Default None):
set :linked_files, %w{config/database.yml config/secrets.yml config/puma.rb}

set :linked_dirs,  %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir #{shared_path}/tmp/sockets -p"
#       execute "mkdir #{shared_path}/tmp/pids -p"
#     end
#   end
#   # before :starting,     :make_dirs
#   # before :start, :make_dirs
# end

namespace :deploy do
  before 'check:linked_files', 'puma:config'
  before 'check:linked_files', 'puma:nginx_config'
  after 'puma:start', 'nginx:restart'
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
