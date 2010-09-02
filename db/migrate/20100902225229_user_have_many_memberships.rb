class UserHaveManyMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships_users, :id => false do |t|
      t.references :membership, :user
    end
  end
 
  def self.down
    drop_table :memberships_users
  end
end
