# == Schema Information
#
# Table name: characters
#
#  id          :bigint           not null, primary key
#  description :string
#  image       :string
#  name        :string           not null
#
# Indexes
#
#  index_characters_on_image  (image)
#
class AnimationSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url

  def image_url
    object.image.url
  end
end
