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

ActiveRecord::Schema.define(version: 20170711231908) do

  create_table "price_ranges", force: :cascade do |t|
    t.integer "property_id"
    t.date "start_date"
    t.date "end_date"
    t.decimal "daily_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_price_ranges_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "city"
    t.string "state"
    t.text "description"
    t.string "photo"
    t.integer "minimun_rent"
    t.integer "maximum_rent"
    t.text "rules"
    t.string "rent_purpose"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner"
    t.string "property_type"
    t.string "title"
    t.decimal "daily_rate"
    t.integer "maximum_guests"
  end

  create_table "proposals", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.decimal "total_amount"
    t.integer "total_guests"
    t.string "name"
    t.string "email"
    t.string "cpf"
    t.string "phone"
    t.text "observation"
    t.integer "property_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_proposals_on_property_id"
  end

end
