class AnimationsController < ApplicationController
  before_action :set_animation, only: [:show, :episode]

  def index
    @animations = Animation.order(:id)
  end

  def show
    @episodes = @animation.episodes.order(episode_num: :asc)
  end

  def episode
    @episode = Episode.find(params[:episode_id])
  end

  def set_animation
    @animation = Animation.find(params[:id])
  end
end
