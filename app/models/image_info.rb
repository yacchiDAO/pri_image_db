class ImageInfo < ApplicationRecord
  belongs_to :image
  has_many   :image_info_tags
  has_many   :tags, through: :tags
end
