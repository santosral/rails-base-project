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

ActiveRecord::Schema.define(version: 2021_07_10_031959) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.integer "nutritionist_id"
    t.string "caption"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "broker_stocks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "stock_id"
    t.string "company"
    t.float "price"
    t.string "ticker"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "buyer_stocks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "stock_id"
    t.string "company"
    t.float "price"
    t.float "total_price"
    t.integer "quantity"
    t.string "ticker"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "change_percent"
  end

  create_table "comments", force: :cascade do |t|
    t.string "food_name"
    t.integer "user_id"
    t.integer "nutritionist_id"
    t.boolean "like"
    t.string "comment"
    t.integer "articles_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "food_groups", force: :cascade do |t|
    t.string "food_name"
    t.string "group_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string "food_name"
    t.integer "user_id"
    t.integer "comment_id"
    t.string "caption"
    t.string "recipe_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
  end

  create_table "nutritional_informations", force: :cascade do |t|
    t.string "food_name"
    t.string "label"
    t.float "quantity"
    t.string "unit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string "company"
    t.float "price"
    t.string "ticker"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "change_percent"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "stock_id"
    t.integer "broker_id"
    t.string "company"
    t.float "price"
    t.float "total_price"
    t.integer "quantity"
    t.string "ticker"
    t.datetime "created_at", precision: 6, null: false
    t.integer "buyer_id"
    t.string "buyer"
    t.string "seller"
  end

  create_table "user_stocks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "stock_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_id"], name: "index_user_stocks_on_stock_id"
    t.index ["user_id"], name: "index_user_stocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "role"
    t.string "status"
    t.float "money"
    t.string "password_digest"
    t.string "email"
    t.string "username"
    t.string "broker_role"
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "user_stocks", "stocks"
  add_foreign_key "user_stocks", "users"
end
