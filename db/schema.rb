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

ActiveRecord::Schema.define(version: 2020_03_19_213834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acronyms", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "data_refer", limit: 64, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.integer "type_acronym_id", null: false
    t.integer "count_views", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "interactions", force: :cascade do |t|
    t.string "name", null: false
    t.json "user_sends"
    t.integer "status_acronym_id", default: 654, null: false
    t.integer "type_acronym_id", default: 300, null: false
    t.integer "schedule_acronym_id", default: 400, null: false
    t.integer "number_schedule", default: 13, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_interactions_on_name", unique: true
  end

  create_table "message_interactions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "message_id"
    t.decimal "time_focus", default: "0.0"
    t.integer "count_views", default: 0
    t.boolean "favorited", default: false
    t.integer "next_action_acronym_id", default: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_message_interactions_on_message_id"
    t.index ["user_id"], name: "index_message_interactions_on_user_id"
  end

  create_table "message_shares", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "contact_id"
    t.bigint "interaction_id"
    t.integer "interaction_message_id"
    t.integer "propagation_message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_message_shares_on_contact_id"
    t.index ["interaction_id"], name: "index_message_shares_on_interaction_id"
    t.index ["user_id"], name: "index_message_shares_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "date_send", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.bigint "interaction_id"
    t.integer "type_acronym_id", default: 3, null: false
    t.json "sent_users_id"
    t.json "answered_users_id"
    t.integer "interaction_ids"
    t.integer "reference_interaction_id"
    t.integer "type_content_acronym_id", default: 50
    t.string "url"
    t.integer "origin_user_id"
    t.integer "destiny_user_id"
    t.integer "previous_message_id"
    t.integer "contact_id"
    t.integer "destiny_contact_id"
    t.text "content_en"
    t.string "sentimental_category"
    t.decimal "sentimental_score"
    t.boolean "chat_open", default: false
    t.decimal "time_focus", default: "0.0"
    t.integer "count_views", default: 0
    t.boolean "favorited", default: false
    t.integer "next_action_acronym_id", default: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interaction_id"], name: "index_messages_on_interaction_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "entity_name"
    t.string "name", null: false
    t.string "password", default: "123", null: false
    t.integer "type_acronym_id", null: false
    t.boolean "chat_connected", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "message_interactions", "messages"
  add_foreign_key "message_interactions", "users"
  add_foreign_key "message_shares", "contacts"
  add_foreign_key "message_shares", "users"
  add_foreign_key "messages", "interactions"
end
