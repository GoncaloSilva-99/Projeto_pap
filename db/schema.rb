# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_02_20_085621) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admin_profiles_on_user_id"
  end

  create_table "board_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "bio"
    t.date "birth_date"
    t.bigint "club_profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "contact"
    t.index ["club_profile_id"], name: "index_board_profiles_on_club_profile_id"
    t.index ["user_id"], name: "index_board_profiles_on_user_id"
  end

  create_table "club_locker_rooms", force: :cascade do |t|
    t.bigint "club_profile_id", null: false
    t.bigint "club_training_center_id"
    t.bigint "sport_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_profile_id"], name: "index_club_locker_rooms_on_club_profile_id"
    t.index ["club_training_center_id"], name: "index_club_locker_rooms_on_club_training_center_id"
    t.index ["sport_id"], name: "index_club_locker_rooms_on_sport_id"
  end

  create_table "club_pitches", force: :cascade do |t|
    t.bigint "club_profile_id", null: false
    t.bigint "club_training_center_id"
    t.bigint "sport_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pitch_type"
    t.index ["club_profile_id"], name: "index_club_pitches_on_club_profile_id"
    t.index ["club_training_center_id"], name: "index_club_pitches_on_club_training_center_id"
    t.index ["sport_id"], name: "index_club_pitches_on_sport_id"
  end

  create_table "club_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.boolean "status"
    t.integer "approved_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "bio"
    t.date "foundation_date"
    t.integer "contact"
    t.index ["user_id"], name: "index_club_profiles_on_user_id"
  end

  create_table "club_sports", force: :cascade do |t|
    t.bigint "club_profile_id", null: false
    t.bigint "sport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_profile_id"], name: "index_club_sports_on_club_profile_id"
    t.index ["sport_id"], name: "index_club_sports_on_sport_id"
  end

  create_table "club_team_trainings", force: :cascade do |t|
    t.bigint "club_locker_room_id"
    t.bigint "club_pitch_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "recurring"
    t.integer "weekday"
    t.bigint "club_team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pitch_zone"
    t.integer "locker_room_time_before", default: 0
    t.integer "locker_room_time_after", default: 0
    t.string "name"
    t.index ["club_locker_room_id"], name: "index_club_team_trainings_on_club_locker_room_id"
    t.index ["club_pitch_id"], name: "index_club_team_trainings_on_club_pitch_id"
    t.index ["club_team_id"], name: "index_club_team_trainings_on_club_team_id"
  end

  create_table "club_teams", force: :cascade do |t|
    t.bigint "club_profile_id", null: false
    t.string "name"
    t.bigint "sport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_profile_id"], name: "index_club_teams_on_club_profile_id"
    t.index ["sport_id"], name: "index_club_teams_on_sport_id"
  end

  create_table "club_training_centers", force: :cascade do |t|
    t.bigint "club_profile_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sport_id", null: false
    t.index ["club_profile_id"], name: "index_club_training_centers_on_club_profile_id"
    t.index ["sport_id"], name: "index_club_training_centers_on_sport_id"
  end

  create_table "coach_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.date "birth_date"
    t.bigint "club_profile_id"
    t.string "coach_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sport"
    t.string "bio"
    t.integer "contact"
    t.index ["club_profile_id"], name: "index_coach_profiles_on_club_profile_id"
    t.index ["user_id"], name: "index_coach_profiles_on_user_id"
  end

  create_table "coach_teams", force: :cascade do |t|
    t.bigint "coach_profile_id", null: false
    t.bigint "club_team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_team_id"], name: "index_coach_teams_on_club_team_id"
    t.index ["coach_profile_id"], name: "index_coach_teams_on_coach_profile_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_follows_on_followed_id"
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "player_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.date "birth_date"
    t.string "position"
    t.text "bio"
    t.integer "contact"
    t.integer "parents_contact"
    t.bigint "club_profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sport"
    t.string "secondary_position"
    t.string "dominant_foot_or_hand"
    t.index ["club_profile_id"], name: "index_player_profiles_on_club_profile_id"
    t.index ["user_id"], name: "index_player_profiles_on_user_id"
  end

  create_table "player_teams", force: :cascade do |t|
    t.bigint "player_profile_id", null: false
    t.bigint "club_team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_team_id"], name: "index_player_teams_on_club_team_id"
    t.index ["player_profile_id"], name: "index_player_teams_on_player_profile_id"
  end

  create_table "post_comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_comments_on_post_id"
    t.index ["user_id"], name: "index_post_comments_on_user_id"
  end

  create_table "post_likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_likes_on_post_id"
    t.index ["user_id"], name: "index_post_likes_on_user_id"
  end

  create_table "post_views", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "viewed_at"
    t.index ["post_id"], name: "index_post_views_on_post_id"
    t.index ["user_id"], name: "index_post_views_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.integer "likes_count", default: 0, null: false
    t.integer "comments_count", default: 0, null: false
    t.integer "views_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admin_profiles", "users"
  add_foreign_key "board_profiles", "club_profiles"
  add_foreign_key "board_profiles", "users"
  add_foreign_key "club_locker_rooms", "club_profiles"
  add_foreign_key "club_locker_rooms", "club_training_centers"
  add_foreign_key "club_locker_rooms", "sports"
  add_foreign_key "club_pitches", "club_profiles"
  add_foreign_key "club_pitches", "club_training_centers"
  add_foreign_key "club_pitches", "sports"
  add_foreign_key "club_profiles", "users"
  add_foreign_key "club_sports", "club_profiles"
  add_foreign_key "club_sports", "sports"
  add_foreign_key "club_team_trainings", "club_locker_rooms"
  add_foreign_key "club_team_trainings", "club_pitches"
  add_foreign_key "club_team_trainings", "club_teams"
  add_foreign_key "club_teams", "club_profiles"
  add_foreign_key "club_teams", "sports"
  add_foreign_key "club_training_centers", "club_profiles"
  add_foreign_key "club_training_centers", "sports"
  add_foreign_key "coach_profiles", "club_profiles"
  add_foreign_key "coach_profiles", "users"
  add_foreign_key "coach_teams", "club_teams"
  add_foreign_key "coach_teams", "coach_profiles"
  add_foreign_key "follows", "users", column: "followed_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "player_profiles", "club_profiles"
  add_foreign_key "player_profiles", "users"
  add_foreign_key "player_teams", "club_teams"
  add_foreign_key "player_teams", "player_profiles"
  add_foreign_key "post_comments", "posts"
  add_foreign_key "post_comments", "users"
  add_foreign_key "post_likes", "posts"
  add_foreign_key "post_likes", "users"
  add_foreign_key "post_views", "posts"
  add_foreign_key "post_views", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "user_profiles", "users"
end
