class SetEpisodesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :set_episodes, retry: false

  def perform
    Episodes::SetEpisodesService.new.execute
  end
end
