require "open-uri"

module Twitter
  class TweetService
    attr_accessor :twitter

    def initialize
      @twitter = Twitter::REST::Client.new do |config|
        config.consumer_key        = ::Settings.twitter.api_key
        config.consumer_secret     = ::Settings.twitter.api_secret_key
        config.access_token        = ::Settings.twitter.access_token
        config.access_token_secret = ::Settings.twitter.access_token_secret
      end
    end

    def execute(image, message)
      images = Rails.env.production? ? [URI.parse(image.image.url).open] : [File.new(image.image.current_path)]
      @twitter.update_with_media(
        "#{message}\n#{image.animation.name}より\n\n#{::Settings.url}images/#{image.id}\n#PriImage", images
      )
    end

    def search_reply(tweet_obj)
      # リプに送る画像の確定
      search_text = tweet_obj.full_text.gsub(/@PriImage/, "").strip
      images = Images::SearchImagesService.new(search_text).execute
      image = images.empty? ? Image.find_by(id: Image.pluck(:id).sample) : images.sample

      # 画像取得
      # TODO: 共通化
      tweet_images = Rails.env.production? ? [URI.parse(image.image.url).open] : [File.new(image.image.current_path)]
      @twitter.update_with_media(
        "@#{tweet_obj.user.screen_name}\n#{::Settings.url}images/#{image.id}",
        tweet_images,
        in_reply_to_status_id: tweet_obj.id,
      )
    end
  end
end
