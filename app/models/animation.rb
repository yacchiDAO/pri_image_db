# == Schema Information
#
# Table name: animations
#
#  id          :bigint           not null, primary key
#  description :string
#  episode_num :integer
#  image       :string
#  name        :string           not null
#  series_name :string
#
# Indexes
#
#  index_animations_on_image  (image)
#
class Animation < ApplicationRecord
  has_many :character_animations
  has_many :characters, through: :character_animations
  has_many :images
  has_many :episodes

  accepts_nested_attributes_for :character_animations, allow_destroy: true
  mount_uploader :image, ImageUploader

  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      description
      episode_num
      id
      image
      name
      series_name
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[
      character_animations
      characters
      images
      episodes
    ]
  end
end
