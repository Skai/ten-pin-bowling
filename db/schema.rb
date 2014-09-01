# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140901085655) do

  create_table "frames", force: true do |t|
    t.boolean  "is_active"
    t.integer  "roll1_pins"
    t.integer  "roll2_pins"
    t.integer  "roll3_pins"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "idx",        default: 1
    t.integer  "score",      default: 0
    t.string   "flag",       default: ""
  end

  add_index "frames", ["game_id"], name: "index_frames_on_game_id"

  create_table "games", force: true do |t|
    t.string   "name"
    t.integer  "score"
    t.boolean  "is_finished"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_frame", default: 1
    t.integer  "current_roll",  default: 1
  end

end
