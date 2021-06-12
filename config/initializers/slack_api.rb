require "slack"

Slack.configure do |config|
  config.token = Settings.slack.slack_token
end
