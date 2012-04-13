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

ActiveRecord::Schema.define(:version => 20120413003201) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id",                         :null => false
    t.string   "content",          :limit => 600, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment_on_table", :limit => 50,  :null => false
    t.integer  "comment_on_id",    :limit => 8,   :null => false
  end

  create_table "connections", :force => true do |t|
    t.integer  "created_by_user_id"
    t.integer  "story_one_id"
    t.integer  "story_two_id"
    t.string   "description",        :limit => 120
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "morals", :force => true do |t|
    t.string   "content",    :limit => 70, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "morals_stories", :force => true do |t|
    t.integer  "story_id",   :null => false
    t.integer  "moral_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id",                                     :null => false
    t.string   "from",       :limit => 30,                    :null => false
    t.integer  "target_id",                                   :null => false
    t.boolean  "viewed",                   :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", :force => true do |t|
    t.integer  "user_id",                               :null => false
    t.string   "title",                 :limit => 80
    t.string   "story",                 :limit => 8191
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "age",                   :limit => 30
    t.string   "topic",                 :limit => 50
    t.string   "educational_technique"
    t.integer  "parent_story"
    t.string   "moral",                 :limit => 80
    t.integer  "score"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id",                     :null => false
    t.string   "subscribed_to", :limit => 30, :null => false
    t.integer  "target_id",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                   :limit => 100
    t.string   "username",               :limit => 20
    t.string   "encrypted_password"
    t.string   "email",                  :limit => 80
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "is_admin",                              :default => false, :null => false
    t.string   "organization",           :limit => 50
    t.string   "about",                  :limit => 800
    t.boolean  "show_name",                             :default => false
    t.boolean  "show_email",                            :default => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
