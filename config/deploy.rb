set :application, 'npcgaming.brandonmathis.me'
set :repository,  "git://github.com/KeysetTS/NPCGaming.git" 

require "bundler/capistrano"

load 'deploy' if respond_to?(:namespace) # cap2 differentiator

set :default_environment, {'PATH' => '/home/bemathis/.gems:/usr/lib/ruby/gems/1.8:/home/bemathis/bin:/home/bemathis/.gems/bin:/home/bemathis/.gems/bin:/usr/lib/ruby/gems/1.8/bin/:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games'}

default_run_options[:pty] = true

set :scm, 'git'

set :user, 'bemathis'
set :domain, 'npcgaming.brandonmathis.me'
set :branch, 'master'
set :scm_verbose, true

set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/#{application}"


set :bundle_dir, "#{shared_dir}/bundle"

set :use_sudo, false

server domain, :app, :web

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end

  task :linkbundle do
    run "ln -nfs #{shared_path}/bundle/ruby #{current_path}/vendor/ruby"
  end
end

after "deploy:symlink","deploy:linkbundle"
