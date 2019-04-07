class Image < ApplicationRecord
  has_many :character_images
  has_many :characters, through: :character_images
  belongs_to :animation, dependent: :destroy
  has_one :image_info, dependent: :destroy

  accepts_nested_attributes_for :image_info, allow_destroy: true
  accepts_nested_attributes_for :characters, allow_destroy: true

  mount_uploader :image, ImageUploader
end
