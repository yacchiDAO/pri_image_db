class FetchMentionWorker
  include Sidekiq::Worker
  sidekiq_options queue: :fetch_mention, retry: false

  def perform
    return unless Rails.env.production?

    current = Time.current
    service.twitter.mentions_timeline.each do |tw|
      # 自身のツイートは無視
      next if tw.user.screen_name == "PriImage" || tw.retweet?
      next if distance_seconds(current, tw.id.to_i) > 20.0

      # ループ内になるけど毎回叩くよりアクセス数が減る見込み
      last_id = Rails.cache.read(redis_key).to_i
      # 同一のリプライ済みツイートがあるため=も弾く
      next if last_id >= tw.id.to_i

      service.search_reply(tw)
      Rails.cache.write(redis_key, tw.id.to_i)
    end
  end

  private

    def redis_key
      "last_reply"
    end

    def service
      @service ||= Twitter::TweetService.new
    end

    def distance_seconds(current, id)
      # https://qiita.com/riocampos/items/e5544325211976f2cfc1
      current - Time.at(((id >> 22) + 1_288_834_974_657) / 1000.0)
    end
end
