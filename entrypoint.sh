# !/bin/bash
set -e

rm -f ./tmp/pids/server.pid

# Start Puma
bundle exec puma -p 8080
