class Admin::AnimationsController < Admin::ApplicationController
  before_action :set_animation, only: [:edit, :update, :destroy]

  def index
    @q = Animation.ransack(params[:q])
    @q.sorts = 'id' if @q.sorts.empty?
    @animations = @q.result(distinct: true).page(params[:page])
  end

  def new
    @animation = Animation.new
  end
  
  def create
    @animation = Animation.new(animation_params)
    if @animation.save
      flash[:notice] = '新規作成しました'
      redirect_to edit_admin_animation_path(@animation)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @animation.update!(animation_params)
      flash[:notice] = '新規作成しました'
      redirect_to edit_admin_animation_path(@animation)
    else
      flash[:notice] = '新規作成に失敗しました'
      render :new
    end
  end

  def destroy
    if @animation.destroy
      flash[:notice] = '削除しました'
      redirect_to admin_animations_path
    else
      flash[:notice] = '削除に失敗しました'
      redirect_to edit_admin_animations_path(@animation)
    end
  end

  private

  def set_animation
    @animation = Animation.find(params[:id])
  end

  def animation_params
    params.require(:animation).permit(:name, :description, :image, :image_cache, :remove_image)
  end
end
