# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://localhost:6379/0' }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://localhost:6379/0' }
# end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_TLS_URL'] }  #Heroku Redis URL
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_TLS_URL'] }  #Heroku Redis URL
end

