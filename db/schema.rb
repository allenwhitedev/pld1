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

ActiveRecord::Schema.define(version: 20141020014806) do

  create_table "eu_relationships", force: true do |t|
    t.string   "attendee_id"
    t.string   "attending_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eu_relationships", ["attendee_id", "attending_id"], name: "index_eu_relationships_on_attendee_id_and_attending_id", unique: true
  add_index "eu_relationships", ["attendee_id"], name: "index_eu_relationships_on_attendee_id"
  add_index "eu_relationships", ["attending_id"], name: "index_eu_relationships_on_attending_id"

  create_table "eu_rels", force: true do |t|
    t.integer  "attender_id"
    t.integer  "attended_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eu_rels", ["attended_id"], name: "index_eu_rels_on_attended_id"
  add_index "eu_rels", ["attender_id", "attended_id"], name: "index_eu_rels_on_attender_id_and_attended_id", unique: true
  add_index "eu_rels", ["attender_id"], name: "index_eu_rels_on_attender_id"

  create_table "events", force: true do |t|
    t.string   "checkincode"
    t.string   "comment"
    t.boolean  "attendance"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.datetime "event_time"
    t.string   "organization"
    t.integer  "points"
  end

  add_index "events", ["user_id", "created_at"], name: "index_events_on_user_id_and_created_at"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.boolean  "moderator",       default: false
    t.string   "organization"
    t.integer  "total_points",    default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
