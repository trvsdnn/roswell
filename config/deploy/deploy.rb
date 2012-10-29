task :create_sym_links do
  run "ln -sf #{shared_dir}/config.yml #{current_dir}/config/config.yml"
  run "ln -sf #{shared_dir}/log #{current_dir}/log"
  run "ln -sf #{shared_dir}/tmp #{current_dir}/tmp"
  run "ln -sf #{shared_dir}/system #{current_dir}/public/system"
end