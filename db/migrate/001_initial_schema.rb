class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :user_id
      t.text :message
      t.timestamps
    end
    
    create_table "users", :force => true do |t|
      t.string   "login"
      t.string   "first_name"
      t.string   "last_name"
      t.string   "email"
      t.string   "crypted_password",          :limit => 40
      t.string   "salt",                      :limit => 40
      t.string   "remember_token"
      t.datetime "remember_token_expires_at"
      t.timestamps
    end
    
  end

  def self.down
    drop_table :messages
    drop_table :users
  end
end
