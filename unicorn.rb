root = File.expand_path(File.dirname(__FILE__))

working_directory root

listen "#{root}/tmp/unicorn.sock"

pid "#{root}/tmp/unicorn.pid"

timeout 600

worker_processes 2

stderr_path "#{root}/log/unicorn.stderr.log"
stdout_path "#{root}/log/unicorn.stdout.log"
