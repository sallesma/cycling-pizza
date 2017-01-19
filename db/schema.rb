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

ActiveRecord::Schema.define(version: 20170119142918) do

  create_table "station_statuses", force: :cascade do |t|
    t.integer  "station_id"
    t.string   "status"
    t.integer  "stands"
    t.integer  "available_bikes"
    t.integer  "available_stands"
    t.datetime "last_update_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["station_id"], name: "index_station_statuses_on_station_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string   "number"
    t.string   "contract_name"
    t.string   "name"
    t.string   "address"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.boolean  "banking"
    t.boolean  "bonus"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
