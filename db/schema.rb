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

ActiveRecord::Schema.define(version: 20150930203245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "cards", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "card_token"
    t.string   "token"
  end

  add_index "cards", ["user_id"], name: "index_cards_on_user_id", using: :btree

  create_table "favorited_listings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorited_listings", ["listing_id"], name: "index_favorited_listings_on_listing_id", using: :btree
  add_index "favorited_listings", ["user_id"], name: "index_favorited_listings_on_user_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.float    "amount"
    t.integer  "receiver_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "reservation_id"
    t.integer  "payer_id"
    t.string   "card"
    t.string   "card_last4"
  end

  add_index "invoices", ["reservation_id"], name: "index_invoices_on_reservation_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug"
    t.boolean  "active",      default: true
    t.string   "token"
  end

  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.integer  "listing_id"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "locations", ["listing_id"], name: "index_locations_on_listing_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "receiver_id"
    t.string   "subject"
    t.string   "body"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "read",        default: false
    t.string   "token"
    t.string   "reply"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "periods", force: :cascade do |t|
    t.integer  "periodic_id"
    t.string   "periodic_type"
    t.datetime "start"
    t.datetime "end"
  end

  add_index "periods", ["periodic_type", "periodic_id"], name: "index_periods_on_periodic_type_and_periodic_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.string   "caption"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.text     "image_meta"
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "amount"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "date_range"
  end

  add_index "rates", ["rateable_type", "rateable_id"], name: "index_rates_on_rateable_type_and_rateable_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "listing_id"
    t.integer  "booker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "status"
    t.text     "purpose"
    t.boolean  "agreement"
    t.string   "token"
  end

  add_index "reservations", ["listing_id"], name: "index_reservations_on_listing_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "reservation_id"
    t.float    "amound_paid"
    t.datetime "paid_date"
    t.integer  "receiver_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "card_last4"
  end

  add_index "transactions", ["reservation_id"], name: "index_transactions_on_reservation_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.string   "password_salt"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "slug"
    t.string   "publishable_key"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_code"
    t.integer  "role",            default: 0
    t.string   "customer_token"
    t.float    "total_income",    default: 0.0
    t.boolean  "tos"
  end

  add_foreign_key "cards", "users"
  add_foreign_key "favorited_listings", "listings"
  add_foreign_key "favorited_listings", "users"
  add_foreign_key "invoices", "reservations"
  add_foreign_key "listings", "users"
  add_foreign_key "locations", "listings"
  add_foreign_key "messages", "users"
  add_foreign_key "reservations", "listings"
  add_foreign_key "transactions", "reservations"
end
