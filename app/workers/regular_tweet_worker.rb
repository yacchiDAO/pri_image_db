class RegularTweetWorker
  include Sidekiq::Worker

  sidekiq_options queue: :regular_tweet

  def perform
    return unless Rails.env.production?

    image = Image.order("RANDOM()").first
    return if image.blank?

    begin
      Twitter::Tweetv2Service.new.execute(image, image.line.blank? ? "セリフ無し" : image.line)
    rescue => e
      Rails.logger.error "【RegularTweetWorker】#{e.class}: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      raise e # 例外を再発生させ、Sidekiqにリトライさせる
    end
  end
end
