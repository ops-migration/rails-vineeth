# Puma config for use with Thruster
# Thruster runs in front as the HTTP accelerator

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }

threads min_threads_count, max_threads_count

# Thruster will pass THRUSTER_TARGET_PORT (default 3000)
port ENV.fetch("THRUSTER_TARGET_PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "development" }

# Worker count for production
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Allow puma to restart itself when it encounters an error
plugin :tmp_restart
