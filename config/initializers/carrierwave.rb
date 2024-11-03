require "carrierwave/storage/abstract"
require "carrierwave/storage/file"
require "carrierwave/storage/fog"

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = "fog/aws"
    config.fog_directory = "pri-image-talk"
    config.fog_public = false
    config.fog_credentials = {
      provider: "AWS",
      service: "S3",
      endpoint: "https://s3.ap-northeast-1.wasabisys.com",
      aws_access_key_id: Settings.aws.access_key_id,
      aws_secret_access_key: Settings.aws.secret_access_key,
      region: Settings.aws.region,
      path_style: true,
    }
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end
