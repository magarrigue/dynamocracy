class AddUserIdToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :user_id, :integer
  end

  def self.down
    remove_column :proposals, :user_id
  end
end
