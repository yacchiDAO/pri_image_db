class RegularTweetWorker
  include Sidekiq::Worker
  sidekiq_options queue: :regular_tweet, retry: false

  def perform
    return unless Rails.env.production?

    image = Image.find_by(id: Image.pluck(:id).sample)
    Twitter::TweetService.new(image, image.line.blank? ? "セリフ無し" : image.line).execute
  end
end
