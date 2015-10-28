# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151028100349) do

  create_table "brands", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "alphabet",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "ward_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "first_name",             limit: 255, default: ""
    t.string   "family_name",            limit: 255, default: "",    null: false
    t.string   "provider",               limit: 255, default: "",    null: false
    t.string   "uid",                    limit: 255, default: "",    null: false
    t.integer  "station_id",             limit: 4
    t.integer  "ward_id",                limit: 4
    t.boolean  "admin",                              default: false, null: false
    t.string   "image_file_name",        limit: 255
    t.string   "image_content_type",     limit: 255
    t.integer  "image_file_size",        limit: 4
    t.datetime "image_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wards", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "wears", force: :cascade do |t|
    t.integer  "price",               limit: 4
    t.integer  "brand_id",            limit: 4
    t.integer  "user_id",             limit: 4
    t.boolean  "rent_or_not",                     default: false, null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "wimage_file_name",    limit: 255
    t.string   "wimage_content_type", limit: 255
    t.integer  "wimage_file_size",    limit: 4
    t.datetime "wimage_updated_at"
    t.integer  "month_price",         limit: 4,                   null: false
  end

end
