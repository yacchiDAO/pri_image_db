class Episode < ApplicationRecord
  belongs_to :animation

  class << self
    def find_or_create(series:, episode_num:, animation_id:)
      obj = where(animation_id: animation_id).find_by(episode_num: episode_num)
      return obj unless obj.nil?
      obj = create(series: series, episode_num: episode_num, animation_id: animation_id)
      obj
    end
  end
end
