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

ActiveRecord::Schema.define(version: 20160905232651) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arcs", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "arc_position"
    t.boolean  "enabled"
  end

  create_table "comic_tags", force: true do |t|
    t.integer "comic_id"
    t.integer "tag_id"
  end

  create_table "comics", force: true do |t|
    t.string   "title"
    t.string   "desc"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "enabled"
    t.integer  "arc_id"
  end

  create_table "comments", force: true do |t|
    t.integer  "comic_id"
    t.string   "body"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newsies", force: true do |t|
    t.string   "title"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sketches", force: true do |t|
    t.text     "info"
    t.boolean  "working",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string "word"
  end

end
