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

ActiveRecord::Schema.define(version: 2021_09_01_131708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affected_musicians", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "change_mails", force: :cascade do |t|
    t.string "email", null: false
    t.string "change_email", null: false
    t.integer "status", null: false
    t.string "token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "equipment", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "instrument_type_id"
    t.index ["instrument_type_id"], name: "index_equipment_on_instrument_type_id"
  end

  create_table "instrument_to_equipments", force: :cascade do |t|
    t.bigint "instrument_id"
    t.bigint "equipment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["equipment_id"], name: "index_instrument_to_equipments_on_equipment_id"
    t.index ["instrument_id"], name: "index_instrument_to_equipments_on_instrument_id"
  end

  create_table "instrument_to_live_experiences", force: :cascade do |t|
    t.bigint "instrument_id"
    t.bigint "live_experience_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["instrument_id"], name: "index_instrument_to_live_experiences_on_instrument_id"
    t.index ["live_experience_id"], name: "index_instrument_to_live_experiences_on_live_experience_id"
  end

  create_table "instrument_to_special_skills", force: :cascade do |t|
    t.bigint "instrument_id"
    t.bigint "special_skill_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["instrument_id"], name: "index_instrument_to_special_skills_on_instrument_id"
    t.index ["special_skill_id"], name: "index_instrument_to_special_skills_on_special_skill_id"
  end

  create_table "instrument_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "instruments", force: :cascade do |t|
    t.integer "experience", null: false
    t.integer "skill_level", null: false
    t.integer "position", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "instrument_type_id"
    t.index ["instrument_type_id"], name: "index_instruments_on_instrument_type_id"
    t.index ["user_id"], name: "index_instruments_on_user_id"
  end

  create_table "live_experiences", force: :cascade do |t|
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "music_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "registration_mails", force: :cascade do |t|
    t.string "email", null: false
    t.integer "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "token", null: false
  end

  create_table "special_skills", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "instrument_type_id"
    t.index ["instrument_type_id"], name: "index_special_skills_on_instrument_type_id"
  end

  create_table "user_active_dates", force: :cascade do |t|
    t.integer "date", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_active_dates_on_user_id"
  end

  create_table "user_profile_images", force: :cascade do |t|
    t.string "image", null: false
    t.integer "position", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_profile_images_on_user_id"
  end

  create_table "user_sns_services", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.integer "sns_type"
    t.index ["user_id"], name: "index_user_sns_services_on_user_id"
  end

  create_table "user_to_affected_musicians", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "affected_musician_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.index ["affected_musician_id"], name: "index_user_to_affected_musicians_on_affected_musician_id"
    t.index ["user_id"], name: "index_user_to_affected_musicians_on_user_id"
  end

  create_table "user_to_music_categories", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "music_category_id"
    t.integer "position", null: false
    t.index ["music_category_id"], name: "index_user_to_music_categories_on_music_category_id"
    t.index ["user_id"], name: "index_user_to_music_categories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "nickname", null: false
    t.integer "sex", null: false
    t.integer "birth_year", null: false
    t.integer "birth_month", null: false
    t.integer "birth_day", null: false
    t.text "introduction", null: false
    t.integer "authentication_flag", null: false
    t.text "tweet", null: false
    t.bigint "prefecture_id"
    t.index ["prefecture_id"], name: "index_users_on_prefecture_id"
  end

  add_foreign_key "equipment", "instrument_types"
  add_foreign_key "instrument_to_equipments", "equipment"
  add_foreign_key "instrument_to_equipments", "instruments"
  add_foreign_key "instrument_to_live_experiences", "instruments"
  add_foreign_key "instrument_to_live_experiences", "live_experiences"
  add_foreign_key "instrument_to_special_skills", "instruments"
  add_foreign_key "instrument_to_special_skills", "special_skills"
  add_foreign_key "instruments", "instrument_types"
  add_foreign_key "instruments", "users"
  add_foreign_key "special_skills", "instrument_types"
  add_foreign_key "user_active_dates", "users"
  add_foreign_key "user_profile_images", "users"
  add_foreign_key "user_sns_services", "users"
  add_foreign_key "user_to_affected_musicians", "affected_musicians"
  add_foreign_key "user_to_affected_musicians", "users"
  add_foreign_key "user_to_music_categories", "music_categories"
  add_foreign_key "user_to_music_categories", "users"
  add_foreign_key "users", "prefectures"
end
