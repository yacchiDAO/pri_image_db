class Api::ImagesController < Api::ApplicationController
  def index
    @images = Images::SearchImagesService.new(params[:q]).execute.page(params[:page])
    render json: @images, each_serializer: ImageSerializer
  end

  def random
    @image = Image.find_by(id: Image.pluck(:id).sample)
    render json: @image, serializer: ImageSerializer
  end
end
