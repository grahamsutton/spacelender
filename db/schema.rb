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

ActiveRecord::Schema.define(version: 20150722072418) do

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
    t.integer  "listing_id"
  end

  add_index "pictures", ["listing_id"], name: "index_pictures_on_listing_id", using: :btree

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
  end

  add_index "reservations", ["listing_id"], name: "index_reservations_on_listing_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.string   "password_salt"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "slug"
    t.string   "publishable_key"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_code"
    t.integer  "role",            default: 0
  end

  add_foreign_key "invoices", "listings"
  add_foreign_key "listings", "users"
  add_foreign_key "locations", "listings"
  add_foreign_key "messages", "users"
  add_foreign_key "pictures", "listings"
  add_foreign_key "reservations", "listings"
end
