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

ActiveRecord::Schema.define(version: 20170710195943) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "forecasts", force: :cascade do |t|
    t.string   "provider_name"
    t.integer  "provider_city_id"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "effective_at"
    t.string   "main"
    t.string   "secondary"
    t.decimal  "temperature"
    t.decimal  "humidity"
    t.decimal  "clouds"
    t.decimal  "wind"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "holidays", force: :cascade do |t|
    t.string   "country"
    t.string   "name"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "predictions", force: :cascade do |t|
    t.integer  "station_id"
    t.decimal  "available_bikes"
    t.decimal  "available_stands"
    t.string   "predictor"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.datetime "valid_at",             null: false
    t.integer  "forecast_id"
    t.integer  "evaluating_status_id"
    t.index ["evaluating_status_id"], name: "index_predictions_on_evaluating_status_id", using: :btree
    t.index ["forecast_id"], name: "index_predictions_on_forecast_id", using: :btree
    t.index ["station_id"], name: "index_predictions_on_station_id", using: :btree
  end

  create_table "station_statuses", force: :cascade do |t|
    t.integer  "station_id"
    t.string   "status"
    t.integer  "stands"
    t.integer  "available_bikes"
    t.integer  "available_stands"
    t.datetime "last_update_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["station_id"], name: "index_station_statuses_on_station_id", using: :btree
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
    t.index ["contract_name", "number"], name: "index_stations_on_contract_name_and_number", using: :btree
  end

  create_table "weathers", force: :cascade do |t|
    t.string   "provider_name"
    t.integer  "provider_city_id"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "main"
    t.string   "secondary"
    t.decimal  "wind"
    t.decimal  "clouds"
    t.decimal  "temperature"
    t.decimal  "humidity"
    t.datetime "sunset"
    t.datetime "sunrise"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_foreign_key "predictions", "stations"
  add_foreign_key "station_statuses", "stations"
end
