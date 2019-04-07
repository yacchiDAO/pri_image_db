class Character < ApplicationRecord
  has_many :character_images
  has_many :character_animations
  has_many :animations, through: :character_animations
  has_many :images, through: :character_images

  accepts_nested_attributes_for :character_animations, allow_destroy: true
  accepts_nested_attributes_for :animations, allow_destroy: true
end
