# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_10_09_185543) do
  create_table "configurations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "moon_battery_id", null: false
    t.string "key", null: false
    t.string "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["moon_battery_id"], name: "index_configurations_on_moon_battery_id"
  end

  create_table "lunar_cells", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moon_batteries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "mac_address", null: false
    t.string "serial_number", limit: 6, null: false
    t.datetime "last_ping"
    t.integer "charge_level", default: 0, null: false
    t.bigint "connected_lunar_cell_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connected_lunar_cell_id"], name: "index_moon_batteries_on_connected_lunar_cell_id"
    t.index ["mac_address"], name: "index_moon_batteries_on_mac_address", unique: true
    t.index ["serial_number"], name: "index_moon_batteries_on_serial_number", unique: true
  end

  add_foreign_key "configurations", "moon_batteries"
  add_foreign_key "moon_batteries", "lunar_cells", column: "connected_lunar_cell_id"
end
