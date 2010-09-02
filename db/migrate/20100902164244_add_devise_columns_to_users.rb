class AddDeviseColumnsToUsers < ActiveRecord::Migration
  def self.up
    drop_table :users
    
    create_table :users do |t| 
      t.database_authenticatable
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      t.timestamps
      t.openid_authenticatable
    end
    add_index :users, :identity_url, :unique => true
    add_index :users, :email, :unique => true
    
  end
  def self.down
    drop_table :users
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :openid

      t.timestamps
    end
  end
end
