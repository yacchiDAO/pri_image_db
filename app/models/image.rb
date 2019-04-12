class Image < ApplicationRecord
  has_many :character_images
  has_many :characters, through: :character_images
  belongs_to :animation

  accepts_nested_attributes_for :characters, allow_destroy: true

  mount_uploader :image, ImageUploader

  scope :character_ids_and_search, -> character_ids {
    character_ids.map { |character_id|
      joins(:character_images).merge(CharacterImage.where(character_id: character_id))
    }.inject(:&).uniq
  }

  def open_count_increment
    self.update!(open_count: self.open_count + 1)
  end
end
