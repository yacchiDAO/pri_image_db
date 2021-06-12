module Slack
  class SlackNotificationService
    def initialize(image)
      @image = image
    end

    def execute
      text = <<-TEXT
      新しい画像がアップロードされました
      #{::Settings.url}images/#{@image.id}
      TEXT
      Slack.chat_postMessage text: text, channel: "#pri_image", icon_url: "/slack_icon.png",
                             attachments: [{ image_url: @image.image.url }]
    end
  end
end
