class Tag < ApplicationRecord
  has_many :image_info_tags
  has_many :image_infos, through: :image_info_tags
end
