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

ActiveRecord::Schema.define(version: 20150625191858) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "facebook_users", force: :cascade do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "avatar_url"
    t.integer  "runner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "facebook_users", ["runner_id"], name: "index_facebook_users_on_runner_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "planned_runs", force: :cascade do |t|
    t.date     "date"
    t.integer  "group_id"
    t.text     "training_plan"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "runners", force: :cascade do |t|
    t.string   "name"
    t.integer  "group_id"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.string   "password_digest"
  end

  create_table "runs", force: :cascade do |t|
    t.integer  "runner_id"
    t.string   "date"
    t.text     "training_plan"
    t.text     "progress"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "planned_run_id"
  end

end
