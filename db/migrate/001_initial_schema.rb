class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :user_id
      t.text :message
    end
  end

  def self.down
    drop_table :messages
  end
end
