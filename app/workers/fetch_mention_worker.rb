class FetchMentionWorker
  include Sidekiq::Worker
  sidekiq_options queue: :fetch_mention, retry: false

  def perform
    return unless Rails.env.production?

    service = Twitter::TweetService.new
    current = Time.current
    service.twitter.mentions_timeline.each do |tw|
      # 自身のツイートは無視
      next if tw.user.screen_name == "PriImage"
      next if tw.retweet?

      # https://qiita.com/riocampos/items/e5544325211976f2cfc1
      distance_seconds = current - Time.at(((tw.id.to_i >> 22) + 1_288_834_974_657) / 1000.0)

      service.search_reply(tw) if distance_seconds <= 10.0
    end
  end
end
