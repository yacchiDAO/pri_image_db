# == Schema Information
#
# Table name: character_images
#
#  id           :bigint           not null, primary key
#  character_id :integer          not null
#  image_id     :integer          not null
#
# Indexes
#
#  index_character_images_on_character_id_and_image_id  (character_id,image_id)
#
FactoryBot.define do
  factory :character_image do
  end
end
