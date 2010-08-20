# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100819230721) do

  create_table "open_id_associations", :force => true do |t|
    t.binary  "server_url", :null => false
    t.string  "handle",     :null => false
    t.binary  "secret",     :null => false
    t.integer "issued",     :null => false
    t.integer "lifetime",   :null => false
    t.string  "assoc_type", :null => false
  end

  create_table "open_id_nonces", :force => true do |t|
    t.string  "server_url", :null => false
    t.integer "timestamp",  :null => false
    t.string  "salt",       :null => false
  end

  create_table "proposals", :force => true do |t|
    t.text     "text"
    t.string   "status",           :default => "open", :null => false
    t.datetime "opening_at",                           :null => false
    t.datetime "closing_at",                           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "yes_count",        :default => 0
    t.integer  "no_count",         :default => 0
    t.integer  "support_count",    :default => 0
    t.integer  "cancelled_by_id"
    t.integer  "signatures_count", :default => 0
  end

  create_table "signatures", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "proposal_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "signatures", ["user_id", "proposal_id"], :name => "index_signatures_on_user_id_and_proposal_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "nickname"
    t.string   "email"
    t.string   "openid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.string   "value"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "proposal_id"
  end

end
