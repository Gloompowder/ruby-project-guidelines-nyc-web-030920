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

ActiveRecord::Schema.define(version: 20200410135239) do

  create_table "forecasts", force: :cascade do |t|
    t.string "date"
    t.string "time"
    t.string "weather"
    t.string "temperature"
    t.string "humidity"
  end

  create_table "interactions", force: :cascade do |t|
    t.string  "action"
    t.integer "plant_id"
    t.integer "user_id"
    t.integer "forecast_id"
  end

  create_table "ownerships", force: :cascade do |t|
    t.integer "plant_id"
    t.integer "user_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string  "nickname"
    t.string  "common_name"
    t.string  "scientific_name"
    t.float   "temperature_minimum"
    t.float   "percipitation_maximum"
    t.float   "percipitiation_minimum"
    t.string  "moisture_use"
    t.integer "serial"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "location"
  end

end
