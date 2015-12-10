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

ActiveRecord::Schema.define(version: 20151209215805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hoontas", force: :cascade do |t|
    t.string "hoonta_name"
    t.string "hoonta_password"
  end

  create_table "ideas", force: :cascade do |t|
    t.string  "idea_name"
    t.integer "user_id"
    t.integer "topic_id"
  end

  create_table "rosters", force: :cascade do |t|
    t.integer "user_id"
    t.integer "hoonta_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string  "topic_name"
    t.string  "deadline"
    t.integer "user_id"
    t.integer "hoonta_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "display_name"
    t.string "email"
    t.string "password_digest"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "idea_id"
  end

end
