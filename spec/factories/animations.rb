# == Schema Information
#
# Table name: animations
#
#  id          :bigint           not null, primary key
#  description :string
#  episode_num :integer
#  image       :string
#  name        :string           not null
#  series_name :string
#
# Indexes
#
#  index_animations_on_image  (image)
#
FactoryBot.define do
  factory :animation do
    description { "" }
    episode_num { 0 }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/image.png"), "image/png") }
    name { "name" }
    series_name { "series_name" }

    # after :create do |animation|
    #  animation.update_column(:image, "spec/fixtures/image.png")
    # end
  end
end
