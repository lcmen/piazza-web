is_development = ENV.fetch("RAILS_ENV", "development") == "development"

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

environment ENV.fetch("RAILS_ENV") { "development" }

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
port ENV.fetch("PORT") { 3000 }
worker_timeout 3600 if is_development
workers ENV.fetch("WEB_CONCURRENCY") { is_development ? 0 : 4 }

preload_app! if is_development

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart
