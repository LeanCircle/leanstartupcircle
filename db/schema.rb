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

ActiveRecord::Schema.define(:version => 20130424011818) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.string   "image"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
    t.string   "location"
    t.string   "description"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "meeting_at"
    t.string   "location_name"
    t.string   "location_address"
    t.integer  "group_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "event_url"
    t.integer  "event_id"
    t.integer  "yes_rsvp_count"
  end

  add_index "events", ["group_id"], :name => "index_events_on_group_id"

  create_table "groups", :force => true do |t|
    t.integer  "meetup_id"
    t.integer  "organizer_id"
    t.string   "name"
    t.text     "description"
    t.string   "facebook_link"
    t.string   "twitter_link"
    t.string   "linkedin_link"
    t.string   "googleplus_link"
    t.string   "other_link"
    t.string   "meetup_link"
    t.string   "city"
    t.string   "country"
    t.string   "province"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "highres_photo_url"
    t.string   "photo_url"
    t.string   "thumbnail_url"
    t.string   "join_mode"
    t.string   "visibility"
    t.boolean  "approval",          :default => false
    t.string   "slug"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "country_code"
    t.boolean  "lsc",               :default => false
    t.integer  "user_id"
    t.integer  "members_count"
  end

  add_index "groups", ["latitude", "longitude"], :name => "index_meetups_on_latitude_and_longitude"
  add_index "groups", ["slug"], :name => "index_meetups_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",       :null => false
    t.string   "encrypted_password",     :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "name"
    t.string   "phone"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "zip_code"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.string   "role",                   :default => "member"
    t.string   "slug"
    t.string   "main_url"
    t.string   "main_description"
    t.string   "main_image"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["latitude", "longitude"], :name => "index_users_on_latitude_and_longitude"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
