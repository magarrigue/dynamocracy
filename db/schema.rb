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

ActiveRecord::Schema.define(:version => 20100907211146) do

  create_table "crews", :force => true do |t|
    t.string   "name"
    t.text     "constitution"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "crew_id"
    t.integer  "user_id"
    t.string   "email"
    t.datetime "sent_at"
    t.datetime "expire_at"
    t.datetime "validated_at"
    t.string   "invitation_token"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.string   "role"
    t.integer  "crew_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["crew_id", "user_id"], :name => "index_memberships_on_crew_id_and_user_id", :unique => true

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
    t.integer  "pass_count",       :default => 0
    t.integer  "crew_id",                              :null => false
  end

  create_table "signatures", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "proposal_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "signatures", ["user_id", "proposal_id"], :name => "index_signatures_on_user_id_and_proposal_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => ""
    t.string   "password_salt",                       :default => ""
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identity_url"
    t.string   "invitation_token",     :limit => 20
    t.datetime "invitation_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["identity_url"], :name => "index_users_on_identity_url", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"

  create_table "votes", :force => true do |t|
    t.string   "value"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "proposal_id"
  end

end
