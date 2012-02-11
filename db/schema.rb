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

ActiveRecord::Schema.define(:version => 20120203235857) do

  create_table "characters", :force => true do |t|
    t.integer  "number",         :null => false
    t.string   "name",           :null => false
    t.string   "born"
    t.string   "country"
    t.string   "assignment"
    t.string   "specialisation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "portrait"
  end

  add_index "characters", ["user_id"], :name => "index_characters_on_user_id"

  create_table "evaluations", :id => false, :force => true do |t|
    t.integer  "mission_id",   :null => false
    t.integer  "character_id", :null => false
    t.integer  "author_id",    :null => false
    t.text     "content",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evaluations", ["mission_id", "character_id", "author_id"], :name => "index_evaluations_on_mission_id_and_character_id_and_author_id", :unique => true

  create_table "mission_attendances", :id => false, :force => true do |t|
    t.integer "mission_id"
    t.integer "character_id"
    t.text    "report"
  end

  add_index "mission_attendances", ["mission_id", "character_id"], :name => "index_mission_attendances_on_mission_id_and_character_id", :unique => true

  create_table "missions", :force => true do |t|
    t.integer  "number",      :null => false
    t.string   "name",        :null => false
    t.string   "date"
    t.string   "location"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "character_id", :null => false
    t.text     "content",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["character_id"], :name => "index_posts_on_character_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",     :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                                                      :null => false
    t.string   "role",                                  :default => "user", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
