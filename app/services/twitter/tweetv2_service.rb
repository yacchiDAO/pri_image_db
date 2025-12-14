# require 'oauth'
# require 'json'
# require 'typhoeus'
# require 'oauth/request_proxy/typhoeus_request'
# require 'dotenv/load'

module Twitter
  class Tweetv2Service
    attr_accessor :twitter, :simple_twitter

    def initialize
      @twitter = Twitter::REST::Client.new do |config|
        config.consumer_key        = ::Settings.twitter.api_key
        config.consumer_secret     = ::Settings.twitter.api_secret_key
        config.access_token        = ::Settings.twitter.access_token
        config.access_token_secret = ::Settings.twitter.access_token_secret
      end
      @simple_twitter = SimpleTwitter::Client.new(
        api_key: ::Settings.twitter.api_key,
        api_secret_key: ::Settings.twitter.api_secret_key,
        access_token: ::Settings.twitter.access_token,
        access_token_secret: ::Settings.twitter.access_token_secret,
      )
    end

    def execute(image, message)
      begin
        # media_idの取得は大本のTwitter gemのuploadがchunk uploadに対応してるのでそっちを使用する
        media = Rails.env.production? ? URI.parse(image.image.url).open : File.new(image.image.current_path)
        media_id = upload(media)[:media_id_string]
        text = "#{message}\n#{image.animation.name}より\n\n#{::Settings.url}images/#{image.id}\n#PriImage"

        # ツイートそのものはsimple twitterのほうが楽なので
        simple_twitter.post("https://api.twitter.com/2/tweets", json: { text: text, media: { media_ids: [media_id] } })
      rescue OpenURI::HTTPError, SocketError => e
        Rails.logger.error "【Tweetv2Service】Media download error for image_id: #{image.id}, url: #{image.image.url}. Error: #{e.message}"
        raise
      rescue Twitter::Error => e
        Rails.logger.error "【Tweetv2Service】Media upload error for image_id: #{image.id}. Error: #{e.message}"
        raise
      rescue => e
        Rails.logger.error "【Tweetv2Service】Tweet post or unexpected error for image_id: #{image.id}. Error: #{e.class}: #{e.message}"
        raise
      end
    end

    # NOTE: 以下のメソッドは https://github.com/sferik/twitter/blob/master/lib/twitter/rest/upload_utils.rb のパクリ
    def upload(media, media_category_prefix: "tweet")
      return chunk_upload(media, "video/mp4", "#{media_category_prefix}_video") if File.extname(media) == ".mp4"

      if File.extname(media) == ".gif" && File.size(media) > 5_000_000
        return chunk_upload(media, "image/gif",
                            "#{media_category_prefix}_gif")
      end

      Twitter::REST::Request.new(twitter, :multipart_post, "https://upload.twitter.com/1.1/media/upload.json",
                                 key: :media, file: media).perform
    end

    private

      def chunk_upload(media, media_type, media_category)
        Timeout.timeout(timeouts&.fetch(:upload, nil), Twitter::Error::TimeoutError) do
          init = Twitter::REST::Request.new(self, :post, "https://upload.twitter.com/1.1/media/upload.json",
                                            command: "INIT",
                                            media_type: media_type,
                                            media_category: media_category,
                                            total_bytes: media.size).perform
          append_media(media, init[:media_id])
          media.close
          finalize_media(init[:media_id])
        end
      end

      # @see https://developer.twitter.com/en/docs/media/upload-media/api-reference/post-media-upload-append
      def append_media(media, media_id)
        until media.eof?
          chunk = media.read(5_000_000)
          seg ||= -1
          Twitter::REST::Request.new(self, :multipart_post, "https://upload.twitter.com/1.1/media/upload.json",
                                     command: "APPEND",
                                     media_id: media_id,
                                     segment_index: seg += 1,
                                     key: :media,
                                     file: StringIO.new(chunk)).perform
        end
      end

      # @see https://developer.twitter.com/en/docs/media/upload-media/api-reference/post-media-upload-finalize
      # @see https://developer.twitter.com/en/docs/media/upload-media/api-reference/get-media-upload-status
      def finalize_media(media_id)
        response = Twitter::REST::Request.new(self, :post, "https://upload.twitter.com/1.1/media/upload.json",
                                              command: "FINALIZE", media_id: media_id).perform
        failed_or_succeeded = %w[failed succeeded]

        loop do
          return response if !response[:processing_info] || failed_or_succeeded.include?(response[:processing_info][:state])

          sleep(response[:processing_info][:check_after_secs])
          response = Twitter::REST::Request.new(self, :get, "https://upload.twitter.com/1.1/media/upload.json",
                                                command: "STATUS", media_id: media_id).perform
        end
        response
      end
  end
end
