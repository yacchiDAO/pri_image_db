# == Schema Information
#
# Table name: character_animations
#
#  id           :bigint           not null, primary key
#  animation_id :integer          not null
#  character_id :integer          not null
#
# Indexes
#
#  index_character_animations_on_character_id_and_animation_id  (character_id,animation_id)
#
class CharacterAnimation < ApplicationRecord
  belongs_to :character
  belongs_to :animation
end
