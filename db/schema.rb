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

ActiveRecord::Schema.define(:version => 20140402024136) do

  create_table "competents", :force => true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fixtures", :force => true do |t|
    t.integer  "competent1_id"
    t.integer  "competent2_id"
    t.date     "match_date"
    t.time     "match_time"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "match_begin"
    t.integer  "referee_id"
    t.string   "stage",         :default => "Group", :null => false
    t.string   "mode"
  end

  add_index "fixtures", ["competent1_id"], :name => "index_fixtures_on_competent1_id"
  add_index "fixtures", ["competent2_id"], :name => "index_fixtures_on_competent2_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "mode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "referees", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "results", :force => true do |t|
    t.integer  "fixture_id"
    t.integer  "winner_id"
    t.integer  "ball_in_table"
    t.integer  "match_number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "results", ["fixture_id"], :name => "index_results_on_fixture_id"
  add_index "results", ["winner_id"], :name => "index_results_on_winner_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
