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

ActiveRecord::Schema.define(:version => 20101120112355) do

  create_table "crews", :force => true do |t|
    t.string    "name"
    t.text      "constitution"
    t.integer   "creator_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "free_proposals", :force => true do |t|
    t.string   "status",             :default => "open", :null => false
    t.datetime "opening_at",                             :null => false
    t.datetime "closing_at",                             :null => false
    t.string   "creator_email"
    t.integer  "yes_count",          :default => 0
    t.integer  "no_count",           :default => 0
    t.integer  "support_count",      :default => 0
    t.string   "cancelled_by_email"
    t.integer  "signatures_count",   :default => 0
    t.integer  "pass_count",         :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer   "crew_id"
    t.integer   "user_id"
    t.string    "email"
    t.timestamp "sent_at"
    t.timestamp "expire_at"
    t.timestamp "validated_at"
    t.string    "invitation_token"
    t.string    "role"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.string    "role"
    t.integer   "crew_id"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "memberships", ["crew_id", "user_id"], :name => "index_memberships_on_crew_id_and_user_id", :unique => true

  create_table "proposals", :force => true do |t|
    t.text     "text"
    t.string   "status",                  :default => "open", :null => false
    t.datetime "opening_at",                                  :null => false
    t.datetime "closing_at",                                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "yes_count",               :default => 0
    t.integer  "no_count",                :default => 0
    t.integer  "support_count",           :default => 0
    t.integer  "cancelled_by_id"
    t.integer  "signatures_count",        :default => 0
    t.integer  "pass_count",              :default => 0
    t.integer  "crew_id",                                     :null => false
    t.boolean  "public_comments_allowed", :default => true,   :null => false
  end

  create_table "signatures", :force => true do |t|
    t.integer   "user_id",     :null => false
    t.integer   "proposal_id", :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "signatures", ["user_id", "proposal_id"], :name => "index_signatures_on_user_id_and_proposal_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                  :default => "", :null => false
    t.string   "encrypted_password",      :limit => 128, :default => "", :null => false
    t.string   "password_salt",                          :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "newsletter_frequency",                   :default => 1
    t.datetime "newsletter_last_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "votes", :force => true do |t|
    t.string    "value"
    t.text      "comment"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "proposal_id"
  end

end
