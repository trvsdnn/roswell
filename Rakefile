$LOAD_PATH.unshift(File.join(Rake.original_dir, 'lib'))

task :environment do
  require File.expand_path('../config/environment', __FILE__)
end

task :setup do
  system "cp -f config/config.yml.example config/config.yml"
  puts "\033[32mSetup is finished\033[0m"
end

namespace :deploy do
  task :staging do
    exec "screwcap config/deploy/staging.rb deploy"
  end

  task :production do
    exec "screwcap config/deploy/production.rb deploy"
  end
end