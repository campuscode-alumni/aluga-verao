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

ActiveRecord::Schema.define(version: 20170714012039) do

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner"
    t.string "property_type"
    t.string "title"
    t.decimal "daily_rate"
    t.integer "maximum_guests"
    t.integer "purpose_id"
    t.index ["purpose_id"], name: "index_properties_on_purpose_id"
  end

  create_table "property_purposes", force: :cascade do |t|
    t.integer "property_id"
    t.integer "purpose_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_property_purposes_on_property_id"
    t.index ["purpose_id"], name: "index_property_purposes_on_purpose_id"
  end

  create_table "propertypurposes", force: :cascade do |t|
    t.integer "property_id"
    t.integer "purpose_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_propertypurposes_on_property_id"
    t.index ["purpose_id"], name: "index_propertypurposes_on_purpose_id"
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
    t.boolean "accepted", default: false
    t.integer "user_id"
    t.index ["property_id"], name: "index_proposals_on_property_id"
    t.index ["user_id"], name: "index_proposals_on_user_id"
  end

  create_table "purposes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
