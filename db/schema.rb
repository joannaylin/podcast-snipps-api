# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_24_161841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string "note"
    t.bigint "user_id"
    t.bigint "episode_id"
    t.string "start_timestamp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["episode_id"], name: "index_comments_on_episode_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.string "episode_name"
    t.integer "duration"
    t.string "description"
    t.string "spotify_episode_id"
    t.string "img_url"
    t.string "show_name"
    t.string "spotify_show_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "access_token"
    t.string "refresh_token"
    t.string "spotify_url"
    t.string "profile_img_url"
    t.string "href"
    t.string "uri"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
