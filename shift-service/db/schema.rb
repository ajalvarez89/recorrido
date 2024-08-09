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

ActiveRecord::Schema[7.1].define(version: 2024_08_07_143109) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "contracts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "service_id"
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "start_hour_weekday", null: false
    t.integer "end_hour_weekday", null: false
    t.integer "start_hour_weekend", null: false
    t.integer "end_hour_weekend", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_contracts_on_service_id"
  end

  create_table "engineer_shifts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "shift_id"
    t.uuid "engineer_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["engineer_id"], name: "index_engineer_shifts_on_engineer_id"
    t.index ["shift_id"], name: "index_engineer_shifts_on_shift_id"
  end

  create_table "engineers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "contract_id"
    t.date "date", null: false
    t.string "day_of_week", null: false
    t.string "start_hour", null: false
    t.string "end_hour", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_shifts_on_contract_id"
  end

  add_foreign_key "contracts", "services"
  add_foreign_key "engineer_shifts", "engineers"
  add_foreign_key "engineer_shifts", "shifts"
  add_foreign_key "shifts", "contracts"
end
