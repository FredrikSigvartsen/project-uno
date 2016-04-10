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

ActiveRecord::Schema.define(version: 20160409205230) do

  create_table "cards", force: :cascade do |t|
    t.integer "value", limit: 4, null: false
    t.string  "color", limit: 6
  end

  create_table "chats", id: false, force: :cascade do |t|
    t.integer "message_id", limit: 4, null: false
    t.integer "game_id",    limit: 4, null: false
  end

  add_index "chats", ["game_id"], name: "game_id", using: :btree

  create_table "game_tables", id: false, force: :cascade do |t|
    t.integer "game_id",      limit: 4, null: false
    t.integer "card_id",      limit: 4, null: false
    t.integer "user_id",      limit: 4
    t.integer "card_in_deck", limit: 4, null: false
    t.integer "card_played",  limit: 4, null: false
  end

  add_index "game_tables", ["card_id"], name: "card_id", using: :btree

  create_table "game_users", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4, null: false
    t.integer "game_id", limit: 4, null: false
  end

  add_index "game_users", ["game_id"], name: "game_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer "host_id", limit: 4, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id", limit: 4,   null: false
    t.string   "message", limit: 512
    t.datetime "time"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "avatar",                 limit: 60
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
