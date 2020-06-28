class Api::ImagesController < Api::ApplicationController
  def index
    @images = Images::SearchImagesService.new(params[:q]).execute
    # TODO: json serializer
    render json: @images #, each_serializer: ImageSerializer
  end

  def random
    # @image = Image rangdom
  end
end
