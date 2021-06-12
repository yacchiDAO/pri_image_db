# == Schema Information
#
# Table name: episodes
#
#  id                    :bigint           not null, primary key
#  animation_production  :string
#  animation_supervision :string
#  broadcast_date        :string
#  episode_num           :integer
#  key                   :string
#  production            :string
#  script                :string
#  series                :string
#  story_board           :string
#  story_board_jp        :string
#  subtitle              :string
#  animation_id          :integer          not null
#
class Episode < ApplicationRecord
  belongs_to :animation

  class << self
    def find_or_create(series:, episode_num:, animation_id:)
      obj = where(animation_id: animation_id).find_by(episode_num: episode_num)
      return obj unless obj.nil?

      create(series: series, episode_num: episode_num, animation_id: animation_id)
    end
  end
end
