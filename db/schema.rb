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

ActiveRecord::Schema.define(:version => 20090305115327) do

  create_table "comments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "commentary_id"
    t.string   "commentary_type"
    t.string   "title"
    t.text     "comment"
    t.boolean  "delta",           :default => false, :null => false
  end

  add_index "comments", ["commentary_id", "commentary_type"], :name => "index_comments_on_commentary_id_and_commentary_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "events", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title",                   :default => "",    :null => false
    t.string   "perex",                   :default => "",    :null => false
    t.string   "location"
    t.string   "link"
    t.text     "description"
    t.datetime "event_date"
    t.boolean  "approved",                :default => false, :null => false
    t.string   "eventphoto_file_name"
    t.string   "eventphoto_content_type"
    t.integer  "eventphoto_file_size"
    t.datetime "eventphoto_updated_at"
    t.boolean  "delta",                   :default => false, :null => false
  end

  add_index "events", ["event_date"], :name => "index_events_on_event_date"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "file_atts", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "title"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_att_file_name"
    t.string   "file_att_content_type"
    t.integer  "file_att_file_size"
    t.datetime "file_att_updated_at"
  end

  add_index "file_atts", ["attachable_id", "attachable_type"], :name => "index_file_atts_on_attachable_id_and_attachable_type"

  create_table "forums", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "perex"
    t.integer  "topics_count", :default => 0, :null => false
  end

  create_table "helps", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",       :default => "",    :null => false
    t.string   "perex",       :default => "",    :null => false
    t.text     "description"
    t.integer  "hits",        :default => 0,     :null => false
    t.boolean  "delta",       :default => false, :null => false
  end

  create_table "items", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "library_id"
    t.string   "title",                  :default => "",    :null => false
    t.string   "perex",                  :default => "",    :null => false
    t.string   "link"
    t.text     "description"
    t.datetime "event_date"
    t.boolean  "approved",               :default => false, :null => false
    t.boolean  "delta",                  :default => false, :null => false
    t.string   "itemphoto_file_name"
    t.string   "itemphoto_content_type"
    t.integer  "itemphoto_file_size"
    t.datetime "itemphoto_updated_at"
  end

  add_index "items", ["library_id"], :name => "index_items_on_library_id"
  add_index "items", ["user_id"], :name => "index_items_on_user_id"

  create_table "libraries", :force => true do |t|
    t.string   "title"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logged_exceptions", :force => true do |t|
    t.string   "exception_class"
    t.string   "controller_name"
    t.string   "action_name"
    t.text     "message"
    t.text     "backtrace"
    t.text     "environment"
    t.text     "request"
    t.datetime "created_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "title"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "photos", ["attachable_id", "attachable_type"], :name => "index_photos_on_attachable_id_and_attachable_type"

  create_table "posts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "body"
    t.boolean  "delta",      :default => false, :null => false
  end

  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "questions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title",       :default => "",    :null => false
    t.string   "perex",       :default => "",    :null => false
    t.text     "description"
    t.boolean  "active",      :default => false, :null => false
    t.boolean  "solved",      :default => false, :null => false
  end

  add_index "questions", ["user_id"], :name => "index_questions_on_user_id"

  create_table "rights", :force => true do |t|
    t.string "name"
    t.string "controller"
    t.string "action"
  end

  create_table "rights_roles", :id => false, :force => true do |t|
    t.integer "right_id"
    t.integer "role_id"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "topics", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "title"
    t.integer  "posts_count", :default => 0, :null => false
    t.integer  "hits",        :default => 0, :null => false
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"
  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",               :default => "",    :null => false
    t.string   "crypted_password",    :default => "",    :null => false
    t.string   "password_salt",       :default => "",    :null => false
    t.string   "persistence_token",   :default => "",    :null => false
    t.string   "perishable_token",    :default => "",    :null => false
    t.string   "email",               :default => "",    :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.integer  "posts_count",         :default => 0,     :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "website"
    t.string   "phone_office"
    t.string   "phone_mobile"
    t.string   "fax"
    t.string   "agency"
    t.string   "user_position"
    t.string   "country"
    t.boolean  "approved",            :default => false, :null => false
    t.text     "specify"
    t.boolean  "delta",               :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
