require "open-uri"

module Twitter
  class TweetService
    def initialize(image, message)
      @image = image
      @message = message
      @twitter = Twitter::REST::Client.new do |config|
        config.consumer_key        = ::Settings.twitter.api_key
        config.consumer_secret     = ::Settings.twitter.api_secret_key
        config.access_token        = ::Settings.twitter.access_token
        config.access_token_secret = ::Settings.twitter.access_token_secret
      end
    end

    def execute
      images = Rails.env.production? ? [URI.parse(@image.image.url).open] : [File.new(@image.image.current_path)]
      @twitter.update_with_media(
        "#{@message}\n#{@image.animation.name}より\n\n#{::Settings.url}images/#{@image.id}\n#PriImage", images
      )
    end
  end
end
