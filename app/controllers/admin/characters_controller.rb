class Admin::CharactersController < Admin::ApplicationController
  before_action :set_character, only: [:edit, :update, :destroy]

  def index
    @q = Character.ransack(params[:q])
    @q.sorts = "id" if @q.sorts.empty?
    @characters = @q.result(distinct: true).page(params[:page])
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      flash[:notice] = "新規作成しました"
      redirect_to edit_admin_character_path(@character)
    else
      flash[:notice] = "新規作成に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    if @character.update!(character_params)
      flash[:notice] = "新規作成しました"
      redirect_to edit_admin_character_path(@character)
    else
      flash[:notice] = "新規作成に失敗しました"
      render :new
    end
  end

  def destroy
    if @character.destroy
      flash[:notice] = "削除しました"
      redirect_to admin_characters_path
    else
      flash[:notice] = "削除に失敗しました"
      redirect_to edit_admin_characters_path(@character)
    end
  end

  private

    def set_character
      @character = Character.find(params[:id])
    end

    def character_params
      params.require(:character).permit(:name, :description, :image, :image_cache, :remove_image, animation_ids: [])
    end
end
