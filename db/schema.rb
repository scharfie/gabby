# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 2) do
  create_table "assets", :force => true do |t|
    t.string   "name"
    t.string   "filename"
    t.integer  "size"
    t.string   "content_type"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "messages", :force => true do |t|
    t.integer "user_id"
    t.text    "message"
    t.integer  "asset_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "nickname"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
