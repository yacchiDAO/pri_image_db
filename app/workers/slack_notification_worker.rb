class SlackNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: :slack_notification, retry: false

  def perform(image_id)
    # return unless Rails.env.production?
    image = Image.find_by(id: image_id)
    Slack::SlackNotificationService.new(image).execute if image
  end
end
