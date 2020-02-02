# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "login_id", null: false
    t.string "password_digest", null: false
  end

  create_table "animations", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "image"
    t.integer "episode_num"
    t.string "series_name"
    t.index ["image"], name: "index_animations_on_image"
  end

  create_table "character_animations", force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "animation_id", null: false
    t.index ["character_id", "animation_id"], name: "index_character_animations_on_character_id_and_animation_id"
  end

  create_table "character_images", force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "image_id", null: false
    t.index ["character_id", "image_id"], name: "index_character_images_on_character_id_and_image_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "image"
    t.index ["image"], name: "index_characters_on_image"
  end

  create_table "episodes", force: :cascade do |t|
    t.integer "animation_id", null: false
    t.integer "episode_num"
    t.string "series"
    t.string "subtitle"
    t.string "animation_production"
    t.string "story_board_jp"
    t.string "story_board"
    t.string "animation_supervision"
    t.string "broadcast_date"
    t.string "production"
    t.string "script"
    t.string "key"
  end

  create_table "image_tags", force: :cascade do |t|
    t.integer "image_id", null: false
    t.integer "tag_id", null: false
    t.index ["tag_id", "image_id"], name: "index_image_tags_on_tag_id_and_image_id"
  end

  create_table "images", force: :cascade do |t|
    t.integer "animation_id", null: false
    t.string "image"
    t.string "line"
    t.string "description"
    t.integer "open_count", default: 0
    t.integer "episode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image", "open_count"], name: "index_images_on_image_and_open_count"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
  end

end
