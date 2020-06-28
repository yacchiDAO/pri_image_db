class ImageSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :line, :description, :open_count, :episode

  has_many :characters
  belongs_to :animation

  def image_url
    object.image.url
  end
end
