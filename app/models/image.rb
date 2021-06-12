# == Schema Information
#
# Table name: images
#
#  id           :bigint           not null, primary key
#  description  :string
#  episode      :integer
#  image        :string
#  line         :string
#  open_count   :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  animation_id :integer          not null
#
# Indexes
#
#  index_images_on_image_and_open_count  (image,open_count)
#
class Image < ApplicationRecord
  has_many :character_images
  has_many :characters, through: :character_images
  belongs_to :animation

  accepts_nested_attributes_for :characters, allow_destroy: true

  validates :image, presence: true

  mount_uploader :image, ImageUploader

  scope :character_ids_and_search, lambda { |character_ids|
    character_ids.map do |character_id|
      joins(:character_images).merge(CharacterImage.where(character_id: character_id))
    end.inject(:&).uniq
  }

  def open_count_increment
    self.update!(open_count: self.open_count + 1)
  end
end
