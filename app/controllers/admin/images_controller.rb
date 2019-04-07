class Admin::ImagesController < Admin::ApplicationController
  before_action :set_image, only: [:edit, :show, :update, :destroy]

  def index
    @q = Image.ransack(params[:q])
    @q.sorts = 'id desc' if @q.sorts.empty?
    @images = @q.result(distinct: true).page(params[:page])
  end

  def new
    @image = Image.new
  end
  
  def create
    if @image = Image.create(image_params)
      flash[:notice] = '新規作成しました'
      redirect_to edit_admin_image_path(@image)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @image.update!(update_image_params)
      flash[:notice] = '新規作成しました'
      redirect_to edit_admin_image_path(@image)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def destroy
    if @image.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_images_path
    else
      flash[:notice] = '削除に失敗しました'
      redirect_to edit_admin_images_path(@image)
    end
  end

  private

  def set_image
    @image = Image.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:image, :image_cache, :remove_image, :animation_id, image_info_attributes: [:line, :description])
  end

  def update_image_params
    params.require(:image).permit(:image, :image_cache, :remove_image, :animation_id, image_info_attributes: [:line, :description], character_ids: [])
  end
end
