# == Schema Information
#
# Table name: characters
#
#  id          :bigint           not null, primary key
#  description :string
#  image       :string
#  name        :string           not null
#
# Indexes
#
#  index_characters_on_image  (image)
#
FactoryBot.define do
  factory :character do
    description { "" }
    image { "image_url" }
    name { "name" }
  end
end
