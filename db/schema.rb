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

ActiveRecord::Schema.define(version: 20150624153520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoices", force: :cascade do |t|
    t.integer  "listing_id"
    t.float    "amount"
    t.datetime "rental_date"
    t.text     "remak"
    t.datetime "paid_date"
    t.integer  "receiver_id"
    t.float    "discount_amount"
    t.string   "discount_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "invoices", ["listing_id"], name: "index_invoices_on_listing_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug"
    t.boolean  "active",      default: true
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
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "reservation_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.integer  "card_number"
    t.integer  "card_verification"
    t.date     "card_expires_on"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "payments", ["reservation_id"], name: "index_payments_on_reservation_id", using: :btree

  create_table "periods", force: :cascade do |t|
    t.integer  "listing_id"
    t.date     "start"
    t.date     "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "periods", ["listing_id"], name: "index_periods_on_listing_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.string   "caption"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "listing_id"
  end

  add_index "pictures", ["listing_id"], name: "index_pictures_on_listing_id", using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "listing_id"
    t.float    "amount"
    t.string   "date_range"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "currency_type"
  end

  add_index "rates", ["listing_id"], name: "index_rates_on_listing_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "listing_id"
    t.integer  "booker_id"
    t.datetime "from_date"
    t.datetime "to_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reservations", ["listing_id"], name: "index_reservations_on_listing_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.string   "password_salt"
    t.integer  "role"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "slug"
  end

  add_foreign_key "invoices", "listings"
  add_foreign_key "listings", "users"
  add_foreign_key "locations", "listings"
  add_foreign_key "messages", "users"
  add_foreign_key "payments", "reservations"
  add_foreign_key "periods", "listings"
  add_foreign_key "pictures", "listings"
  add_foreign_key "rates", "listings"
  add_foreign_key "reservations", "listings"
end
