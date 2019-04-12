class Tag < ApplicationRecord
  has_many :image_tags
  has_many :image, through: :image_tags
end
