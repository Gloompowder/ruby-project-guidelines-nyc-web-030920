# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_10_135239) do

  create_table "forecasts", force: :cascade do |t|
    t.string "date"
    t.string "time"
    t.string "weather"
    t.string "temperature"
    t.string "humidity"
  end

  create_table "interactions", force: :cascade do |t|
    t.string "action"
    t.integer "plant_id"
    t.integer "user_id"
    t.integer "forecast_id"
  end

  create_table "ownerships", force: :cascade do |t|
    t.integer "plant_id"
    t.integer "user_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "nickname"
    t.string "common_name"
    t.string "scientific_name"
    t.float "temperature_minimum"
    t.float "percipitation_maximum"
    t.float "percipitation_minimum"
    t.string "moisture_use"
    t.integer "serial"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "location"
  end

end
