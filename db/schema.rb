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

ActiveRecord::Schema.define(version: 20151208211950) do

  create_table "categories", force: :cascade do |t|
    t.string "category_name",        limit: 255
    t.string "category_description", limit: 255
  end

  create_table "hoontas", force: :cascade do |t|
    t.string "hoonta_name",     limit: 255
    t.string "hoonta_password", limit: 255
  end

  create_table "ideas", force: :cascade do |t|
    t.string  "idea_name",        limit: 255
    t.string  "idea_description", limit: 255
    t.integer "user_id",          limit: 4
    t.integer "category_id",      limit: 4
  end

  create_table "rosters", force: :cascade do |t|
    t.integer "user_id",   limit: 4
    t.integer "hoonta_id", limit: 4
  end

  create_table "topics", force: :cascade do |t|
    t.string  "topic_name",  limit: 255
    t.string  "deadline",    limit: 255
    t.integer "hoonta_id",   limit: 4
    t.integer "category_id", limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name",       limit: 255
    t.string "display_name",    limit: 255
    t.string "email",           limit: 255
    t.string "password_digest", limit: 255
  end

end
