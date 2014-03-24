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

ActiveRecord::Schema.define(:version => 20140324044452) do

  create_table "competents", :force => true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fixtures", :force => true do |t|
    t.integer  "competent1_id"
    t.integer  "competent2_id"
    t.date     "matchDate"
    t.time     "matchTime"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "matchBegin"
  end

  add_index "fixtures", ["competent1_id"], :name => "index_fixtures_on_competent1_id"
  add_index "fixtures", ["competent2_id"], :name => "index_fixtures_on_competent2_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "mode"
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

end
