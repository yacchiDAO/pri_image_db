class AnimationSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url

  def image_url
    object.image.url
  end
end
