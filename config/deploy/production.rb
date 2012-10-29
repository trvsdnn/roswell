use :deploy

server :production, :address => 'example.com', :user => 'deploy', :forward_agent => true

set :app_name, 'example.com'
set :current_dir, "/var/www/#{app_name}/current"
set :shared_dir, "/var/www/#{app_name}/shared"
set :branch, "origin/production"

task :restart do
  run "kill -HUP `cat #{shared_dir}/tmp/pids/unicorn.pid`"
end

task :deploy, :server => :production do
  run "cd #{current_dir}; git fetch && git reset --hard #{branch} && bundle install --deployment"
  create_sym_links
  restart
end

