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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121123180127) do

  create_table "meetups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "meetup_id"
    t.integer  "organizer_id"
    t.string   "link"
    t.string   "city"
    t.string   "country"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "highres_photo_url"
    t.string   "photo_url"
    t.string   "thumbnail_url"
    t.string   "join_mode"
    t.string   "visibility"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "gmaps"
    t.boolean  "approved",          :default => false
    t.boolean  "approval",          :default => false
    t.boolean  "approve",           :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.string   "provider"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "public_profile_url"
    t.string   "email"
    t.string   "zipcode"
    t.string   "user_type"
    t.string   "company_name"
    t.string   "phone"
  end

end
