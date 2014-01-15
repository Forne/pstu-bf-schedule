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

ActiveRecord::Schema.define(version: 20131111172304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auditorium_names", force: true do |t|
    t.string   "name",          null: false
    t.integer  "auditorium_id", null: false
    t.integer  "university_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auditorium_names", ["name", "university_id"], name: "index_auditorium_names_on_name_and_university_id", unique: true, using: :btree

  create_table "auditoriums", force: true do |t|
    t.string   "name",          null: false
    t.string   "shot_name"
    t.integer  "university_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entities", force: true do |t|
    t.datetime "start",         null: false
    t.datetime "end",           null: false
    t.integer  "group_id",      null: false
    t.integer  "teacher_id",    null: false
    t.integer  "type_id"
    t.integer  "subject_id",    null: false
    t.integer  "auditorium_id"
  end

  create_table "entity_types", force: true do |t|
    t.string  "name",      null: false
    t.string  "shot_name", null: false
    t.boolean "important", null: false
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "university_id"
    t.integer  "form_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.string   "parse_name"
    t.boolean  "archive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["name", "university_id"], name: "index_groups_on_name_and_university_id", unique: true, using: :btree

  create_table "subject_names", force: true do |t|
    t.string   "name",          null: false
    t.integer  "subject_id",    null: false
    t.integer  "university_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subject_names", ["name", "university_id"], name: "index_subject_names_on_name_and_university_id", unique: true, using: :btree

  create_table "subjects", force: true do |t|
    t.string   "name",          null: false
    t.string   "shot_name"
    t.integer  "university_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teacher_names", force: true do |t|
    t.string   "name",          null: false
    t.integer  "teacher_id",    null: false
    t.integer  "university_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teacher_names", ["name", "university_id"], name: "index_teacher_names_on_name_and_university_id", unique: true, using: :btree

  create_table "teachers", force: true do |t|
    t.string   "full_name",       null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "patronymic_name"
    t.integer  "sex"
    t.date     "bdate"
    t.integer  "university_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "universities", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name",                    null: false
    t.string   "last_name",                     null: false
    t.integer  "group_id"
    t.integer  "sex",           default: 0
    t.date     "birthday"
    t.integer  "vk_id",                         null: false
    t.boolean  "vk_has_mobile"
    t.boolean  "is_banned",     default: false, null: false
    t.boolean  "is_manager",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
