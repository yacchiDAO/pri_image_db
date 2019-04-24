class CreateTweetWorker
  include Sidekiq::Worker
  sidekiq_options queue: :create_tweet, retry: false

  def perform(image_id)
    return unless Rails.env.production?
    image = Image.find_by(id: image_id)
    Twitter::TweetService.new(image, '新規登録されました').execute if image
  end
end
