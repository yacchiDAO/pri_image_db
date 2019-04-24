Sidekiq.configure_server do |config|
  if Rails.env.production?
    config.redis = { url: ENV.fetch('REDIS_URL') }
  else
    config.redis = { url: 'redis://redis:6379', namespace: "sidekiq" }
  end
end

Sidekiq.configure_client do |config|
  if Rails.env.production?
    config.redis = { url: ENV.fetch('REDIS_URL') }
  else
    config.redis = { url: 'redis://redis:6379', namespace: "sidekiq" }
  end
end
