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
class ImageSerializer < ActiveModel::Serializer
  attributes :id, :image_url, :line, :description, :open_count, :episode

  has_many :characters
  belongs_to :animation

  def image_url
    object.image.url
  end
end
