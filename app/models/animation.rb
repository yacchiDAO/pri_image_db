class Animation < ApplicationRecord
  has_many :character_animations
  has_many :characters, through: :character_animations
  has_many :images
  has_many :episodes

  accepts_nested_attributes_for :character_animations, allow_destroy: true
  mount_uploader :image, ImageUploader

  validates :name, presence: true
end
