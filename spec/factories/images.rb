# == Schema Information
#
# Table name: images
#
#  id           :bigint           not null, primary key
#  description  :string
#  episode      :integer
#  image        :string
#  line         :string
#  open_count   :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  animation_id :integer          not null
#
# Indexes
#
#  index_images_on_image_and_open_count  (image,open_count)
#
FactoryBot.define do
  factory :image do
    description { "" }
    episode { 0 }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/image.png"), "image/png") }
    line { "kokoni serihu" }
    open_count { 0 }
  end
end
