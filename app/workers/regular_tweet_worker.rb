class RegularTweetWorker
  include Sidekiq::Worker
  sidekiq_options queue: :regular_tweet, retry: false

  def perform
    return unless Rails.env.production?

    image = Image.find_by(id: Image.pluck(:id).sample)
    Twitter::Tweetv2Service.new.execute(image, image.line.blank? ? "セリフ無し" : image.line)
  end
end
