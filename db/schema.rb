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

ActiveRecord::Schema.define(version: 2021_07_24_133507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "knowledges", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "team_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_knowledges_on_member_id"
    t.index ["team_id"], name: "index_knowledges_on_team_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_members_on_team_id"
    t.index ["user_id", "team_id"], name: "index_members_on_user_id_and_team_id", unique: true
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.bigint "tip_id", null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tip_id"], name: "index_pictures_on_tip_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "knowledge_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["knowledge_id"], name: "index_stocks_on_knowledge_id"
    t.index ["member_id", "knowledge_id"], name: "index_stocks_on_member_id_and_knowledge_id", unique: true
    t.index ["member_id"], name: "index_stocks_on_member_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "owner_id", null: false
    t.string "name", null: false
    t.boolean "is_solo", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "tips", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.bigint "knowledge_id", null: false
    t.bigint "team_id", null: false
    t.string "name", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["knowledge_id"], name: "index_tips_on_knowledge_id"
    t.index ["member_id"], name: "index_tips_on_member_id"
    t.index ["team_id"], name: "index_tips_on_team_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", default: "", null: false
    t.string "image"
    t.text "introduction"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "knowledges", "members"
  add_foreign_key "knowledges", "teams"
  add_foreign_key "members", "teams"
  add_foreign_key "members", "users"
  add_foreign_key "pictures", "tips"
  add_foreign_key "stocks", "knowledges"
  add_foreign_key "stocks", "members"
  add_foreign_key "teams", "users"
  add_foreign_key "tips", "knowledges"
  add_foreign_key "tips", "members"
  add_foreign_key "tips", "teams"
end
