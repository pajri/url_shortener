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

ActiveRecord::Schema[8.0].define(version: 2025_08_11_144746) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "advertisement_analytics", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "advertisement_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.string "referrer"
    t.string "requested_url"
    t.string "query_parameters"
    t.string "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advertisement_id"], name: "index_advertisement_analytics_on_advertisement_id"
  end

  create_table "advertisement_pointers", force: :cascade do |t|
    t.integer "last_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "advertisements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "label"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
  end

  create_table "urls", id: false, force: :cascade do |t|
    t.uuid "id", default: -> { "gen_random_uuid()" }, null: false
    t.string "long_url"
    t.string "short_url"
    t.datetime "expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "advertisement_analytics", "advertisements"
end
