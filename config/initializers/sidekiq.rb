Sidekiq.configure_server do |config|
  config.redis = if Rails.env.production?
                   { url: ENV.fetch("REDIS_URL"), ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
                 else
                   { url: "redis://redis:6379" }
                 end
end

Sidekiq.configure_client do |config|
  config.redis = if Rails.env.production?
                   { url: ENV.fetch("REDIS_URL"), ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }
                 else
                   { url: "redis://redis:6379" }
                 end
end
