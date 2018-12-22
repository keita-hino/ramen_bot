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

ActiveRecord::Schema.define(version: 2018_11_23_040507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "foodrecords", force: :cascade do |t|
    t.string "store_name"
    t.string "menu_name"
    t.string "taste"
    t.string "thickness"
    t.string "hardness"
    t.string "taste_intensity"
    t.decimal "evalute"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "lineuser_id"
    t.string "picture"
    t.index ["lineuser_id"], name: "index_foodrecords_on_lineuser_id"
  end

  create_table "lineusers", force: :cascade do |t|
    t.text "userid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "temps", force: :cascade do |t|
    t.text "userid"
    t.jsonb "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
