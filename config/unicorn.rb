APP_ROOT = File.expand_path('../../', __FILE__)
CONFIG  = YAML.load_file(File.join(APP_ROOT, 'config/config.yml'))

worker_processes 4
listen CONFIG['port']
timeout 40

working_directory APP_ROOT
pid "#{APP_ROOT}/tmp/pids/unicorn.pid"
stderr_path "#{APP_ROOT}/log/unicorn.stderr.log"
stdout_path "#{APP_ROOT}/log/unicorn.stdout.log"
