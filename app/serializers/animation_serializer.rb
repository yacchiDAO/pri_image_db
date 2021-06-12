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
class AnimationSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url

  def image_url
    object.image.url
  end
end
