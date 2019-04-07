class Animation < ApplicationRecord
  has_many :character_animations
  has_many :characters, through: :character_animations
  has_many :images

  accepts_nested_attributes_for :character_animations, allow_destroy: true
  mount_uploader :image, ImageUploader
end
