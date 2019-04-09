class ImagesController < ApplicationController
  before_action :search_images, only: [:index, :show, :select_characters, :character, :line]

  def index
  end

  def show
    @image = Image.find(params[:id])
  end

  def character 
    @animation = Animation.find_by(id: params[:q][:animation_id_eq])
    @characters = Character.where(id: params[:q][:character_images_character_id_eq_any])
  end

  def line
  end
  
  def select_animation
    @animations = Animation.all
  end

  def select_characters
    @animation = Animation.find_by(id: params[:animation_id])
    if @animation.present?
      @characters = Character.includes(:animations).where(animations: { id: @animation.id })
    else
      @characters = Character.all
    end
  end
  private

  def set_params
    @character_ids = params[:character_ids]
    @animation_ids = params[:animation_ids]
    @line = params[:line]
  end
  
  def search_images
    @q = Image.all

    # fackin relation and search
    if params[:q].present? && @character_ids = params[:q][:character_images_character_id_eq_any] 
      if @character_ids.size >= 2
        images = @q.character_ids_and_search(@character_ids)
        @q = Image.where(id: images.map{ |image| image.id })
      end
    end

    @q = @q.ransack(params[:q])

    @q.sorts = 'id desc' if @q.sorts.empty?
    @images = @q.result(distinct: true).page(params[:page])
  end
end
