# == Schema Information
#
# Table name: tags
#
#  id   :bigint           not null, primary key
#  name :string           not null
#
class Tag < ApplicationRecord
  has_many :image_tags
  has_many :image, through: :image_tags
end
