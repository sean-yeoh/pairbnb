redis: bundle exec redis-server
worker: bundle exec sidekiq -c 3
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb