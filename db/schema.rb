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

ActiveRecord::Schema.define(version: 20150318234705) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "followers", force: :cascade do |t|
    t.integer  "subscriber_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "jots", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "user_id"
    t.integer  "likes_count"
    t.decimal  "latitude",           precision: 11, scale: 8
    t.decimal  "longitude",          precision: 11, scale: 8
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "jot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "displayname"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end