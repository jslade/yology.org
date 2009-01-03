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

ActiveRecord::Schema.define(:version => 20090103071529) do

  create_table "citations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "source_id",   :null => false
    t.integer  "event_id"
    t.integer  "relation_id"
  end

  create_table "events", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tree_id",    :null => false
    t.integer  "place_id"
    t.string   "date",       :null => false
    t.text     "note"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "participants", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id",                       :null => false
    t.integer  "event_id",                        :null => false
    t.boolean  "is_principal", :default => false
    t.integer  "order",        :default => 1,     :null => false
  end

  add_index "participants", ["event_id"], :name => "index_participants_on_event_id"
  add_index "participants", ["person_id"], :name => "index_participants_on_person_id"

  create_table "passwords", :force => true do |t|
    t.integer  "user_id"
    t.string   "reset_code"
    t.datetime "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tree_id",                   :null => false
    t.integer  "gender",     :default => 0, :null => false
    t.string   "name"
    t.string   "given"
    t.string   "surname"
    t.string   "nick"
  end

  create_table "places", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tree_id",    :null => false
    t.string   "level1"
    t.string   "level2"
    t.string   "level3"
    t.string   "level4"
    t.string   "level5"
  end

  create_table "relations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tree_id",    :null => false
    t.integer  "person1_id", :null => false
    t.integer  "person2_id", :null => false
    t.integer  "rtype",      :null => false
  end

  add_index "relations", ["person1_id", "rtype"], :name => "person1_rtype"
  add_index "relations", ["person1_id"], :name => "index_relations_on_person1_id"
  add_index "relations", ["person2_id", "rtype"], :name => "person2_rtype"
  add_index "relations", ["person2_id"], :name => "index_relations_on_person2_id"
  add_index "relations", ["rtype"], :name => "index_relations_on_rtype"

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sources", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tree_id",                    :null => false
    t.text     "source_text",                :null => false
    t.integer  "parent_id"
    t.integer  "order",       :default => 1, :null => false
  end

  create_table "trees", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "identity_url"
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token",            :limit => 40
    t.string   "activation_code",           :limit => 40
    t.string   "state",                                    :default => "passive", :null => false
    t.datetime "remember_token_expires_at"
    t.datetime "activated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
