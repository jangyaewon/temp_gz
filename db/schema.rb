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

ActiveRecord::Schema.define(version: 20180723062139) do

  create_table "districts", force: :cascade do |t|
    t.string   "district_name"
    t.integer  "state_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "image_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string   "menu_name"
    t.integer  "price"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "nicknames", force: :cascade do |t|
    t.string   "word"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "res_name"
    t.string   "detail_addr"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "food_type"
    t.string   "image_path"
    t.string   "parking"
    t.string   "phone"
    t.string   "b_number"
    t.string   "g_name"
    t.integer  "r_count"
    t.integer  "min_price"
    t.integer  "max_price"
    t.text     "b_hour"
    t.integer  "state_id"
    t.integer  "district_id"
    t.integer  "road_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "contents"
  end

  create_table "restaurants_tags", id: false, force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "tag_id"
    t.index ["restaurant_id"], name: "index_restaurants_tags_on_restaurant_id"
    t.index ["tag_id"], name: "index_restaurants_tags_on_tag_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.integer  "taste_eval"
    t.integer  "price_eval"
    t.integer  "service_eval"
    t.string   "image_path"
    t.text     "contents"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "roads", force: :cascade do |t|
    t.string   "road_name"
    t.integer  "district_id"
    t.integer  "state_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "scrabs", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "states", force: :cascade do |t|
    t.string   "state_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "nickname"
    t.string   "provider"
    t.string   "name"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
