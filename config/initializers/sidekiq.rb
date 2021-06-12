Sidekiq.configure_server do |config|
  config.redis = if Rails.env.production?
                   { url: ENV.fetch("REDIS_URL") }
                 else
                   { url: "redis://redis:6379", namespace: "sidekiq" }
                 end
end

Sidekiq.configure_client do |config|
  config.redis = if Rails.env.production?
                   { url: ENV.fetch("REDIS_URL") }
                 else
                   { url: "redis://redis:6379", namespace: "sidekiq" }
                 end
end
