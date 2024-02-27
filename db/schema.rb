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

ActiveRecord::Schema[7.0].define(version: 2024_02_02_150652) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "artists", force: :cascade do |t|
    t.string "avatar_url"
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.jsonb "personal_details", default: {"bio"=>nil, "sex"=>nil, "email"=>nil, "address"=>nil, "interests"=>nil, "languages"=>nil}, null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personal_details"], name: "index_artists_on_personal_details", using: :gin
  end

  create_table "episodes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image_url"
    t.date "released_at"
    t.time "duration"
    t.integer "status"
    t.bigint "video_link_id"
    t.bigint "trailer_link_id"
    t.bigint "season_id", null: false
    t.bigint "serie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_episodes_on_season_id"
    t.index ["serie_id"], name: "index_episodes_on_serie_id"
    t.index ["trailer_link_id"], name: "index_episodes_on_trailer_link_id"
    t.index ["video_link_id"], name: "index_episodes_on_video_link_id"
  end

  create_table "movie_comments", force: :cascade do |t|
    t.text "text"
    t.integer "likes_counter"
    t.bigint "movie_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_comments_on_movie_id"
    t.index ["user_id"], name: "index_movie_comments_on_user_id"
  end

  create_table "movie_genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_movie_genres_on_name", unique: true
  end

  create_table "movie_likes", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_likes_on_movie_id"
    t.index ["user_id"], name: "index_movie_likes_on_user_id"
  end

  create_table "movie_writters", force: :cascade do |t|
    t.string "avatar_url"
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.jsonb "personal_details", default: {"bio"=>nil, "sex"=>nil, "email"=>nil, "address"=>nil, "interests"=>nil, "languages"=>nil}, null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personal_details"], name: "index_movie_writters_on_personal_details", using: :gin
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "category"
    t.string "image_url"
    t.date "released_at"
    t.jsonb "content_details", default: {"country"=>nil, "duration"=>nil, "original_language"=>nil}, null: false
    t.integer "views", default: 0, null: false
    t.integer "likes_counter", default: 0, null: false
    t.integer "comments_counter", default: 0, null: false
    t.integer "status", null: false
    t.bigint "movie_genre_id", null: false
    t.bigint "video_link_id"
    t.bigint "trailer_link_id"
    t.bigint "movie_writter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_details"], name: "index_movies_on_content_details", using: :gin
    t.index ["movie_genre_id"], name: "index_movies_on_movie_genre_id"
    t.index ["movie_writter_id"], name: "index_movies_on_movie_writter_id"
    t.index ["name"], name: "index_movies_on_name", unique: true
    t.index ["trailer_link_id"], name: "index_movies_on_trailer_link_id"
    t.index ["video_link_id"], name: "index_movies_on_video_link_id"
  end

  create_table "outcast_associations", force: :cascade do |t|
    t.bigint "outcast_id", null: false
    t.string "media_association_type", null: false
    t.bigint "media_association_id", null: false
    t.integer "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_association_type", "media_association_id"], name: "index_outcast_associations_on_media_association"
    t.index ["outcast_id"], name: "index_outcast_associations_on_outcast_id"
  end

  create_table "outcasts", force: :cascade do |t|
    t.string "avatar_url"
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.jsonb "personal_details", default: {"bio"=>nil, "sex"=>nil, "email"=>nil, "address"=>nil, "interests"=>nil, "languages"=>nil}, null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personal_details"], name: "index_outcasts_on_personal_details", using: :gin
  end

  create_table "roles", force: :cascade do |t|
    t.integer "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "image_url"
    t.date "released_at"
    t.integer "status", null: false
    t.bigint "video_link_id"
    t.integer "episods_counter"
    t.bigint "serie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serie_id"], name: "index_seasons_on_serie_id"
    t.index ["title"], name: "index_seasons_on_title"
    t.index ["video_link_id"], name: "index_seasons_on_video_link_id"
  end

  create_table "serie_comments", force: :cascade do |t|
    t.text "text"
    t.integer "likes_counter"
    t.bigint "serie_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serie_id"], name: "index_serie_comments_on_serie_id"
    t.index ["user_id"], name: "index_serie_comments_on_user_id"
  end

  create_table "serie_likes", force: :cascade do |t|
    t.bigint "serie_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["serie_id"], name: "index_serie_likes_on_serie_id"
    t.index ["user_id"], name: "index_serie_likes_on_user_id"
  end

  create_table "series", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "category"
    t.string "image_url"
    t.jsonb "content_details", default: {"country"=>nil, "original_language"=>nil}, null: false
    t.integer "views", default: 0, null: false
    t.integer "status", null: false
    t.bigint "movie_genre_id", null: false
    t.bigint "video_link_id"
    t.bigint "movie_writter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_details"], name: "index_series_on_content_details", using: :gin
    t.index ["movie_genre_id"], name: "index_series_on_movie_genre_id"
    t.index ["movie_writter_id"], name: "index_series_on_movie_writter_id"
    t.index ["name"], name: "index_series_on_name", unique: true
    t.index ["video_link_id"], name: "index_series_on_video_link_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "email", null: false
    t.string "username", null: false
    t.string "phone_number", null: false
    t.integer "age_group"
    t.boolean "terms_of_service", null: false
    t.boolean "remember_me"
    t.boolean "welcome_email_send", default: false, null: false
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id", null: false
    t.jsonb "profile", default: {"bio"=>nil, "sex"=>nil, "interests"=>"[]", "languages"=>"[]", "last_name"=>nil, "avatar_url"=>nil, "first_name"=>nil, "date_of_birth"=>nil, "phone_verified"=>false}, null: false
    t.jsonb "location", default: {"city"=>nil, "state"=>nil, "address"=>"", "country"=>nil, "zip_code"=>nil}, null: false
    t.jsonb "social_links", default: {"twitter"=>nil, "youtube"=>nil, "facebook"=>nil, "linkedin"=>nil, "instagram"=>nil}, null: false
    t.integer "verification_status"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["location"], name: "index_users_on_location", using: :gin
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["profile"], name: "index_users_on_profile", using: :gin
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["social_links"], name: "index_users_on_social_links", using: :gin
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "url", null: false
    t.string "title"
    t.integer "status"
    t.jsonb "details", default: {"caption"=>nil, "duration"=>nil, "dimention"=>nil, "mime_type"=>nil, "definition"=>nil}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["details"], name: "index_videos_on_details", using: :gin
  end

  add_foreign_key "episodes", "seasons"
  add_foreign_key "episodes", "series", column: "serie_id"
  add_foreign_key "episodes", "videos", column: "trailer_link_id"
  add_foreign_key "episodes", "videos", column: "video_link_id"
  add_foreign_key "movie_comments", "movies"
  add_foreign_key "movie_comments", "users"
  add_foreign_key "movie_likes", "movies"
  add_foreign_key "movie_likes", "users"
  add_foreign_key "movies", "movie_genres"
  add_foreign_key "movies", "movie_writters"
  add_foreign_key "movies", "videos", column: "trailer_link_id"
  add_foreign_key "movies", "videos", column: "video_link_id"
  add_foreign_key "outcast_associations", "outcasts"
  add_foreign_key "seasons", "series", column: "serie_id"
  add_foreign_key "seasons", "videos", column: "video_link_id"
  add_foreign_key "serie_comments", "series", column: "serie_id"
  add_foreign_key "serie_comments", "users"
  add_foreign_key "serie_likes", "series", column: "serie_id"
  add_foreign_key "serie_likes", "users"
  add_foreign_key "series", "movie_genres"
  add_foreign_key "series", "movie_writters"
  add_foreign_key "series", "videos", column: "video_link_id"
  add_foreign_key "users", "roles"
end
