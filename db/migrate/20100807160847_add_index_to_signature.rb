class AddIndexToSignature < ActiveRecord::Migration
  def self.up
    change_column :signatures, :user_id, :integer, :null => false
    change_column :signatures, :proposal_id, :integer, :null => false
    add_index :signatures, [:user_id, :proposal_id], :unique => true
  end

  def self.down
    remove_index :signatures, [:user_id, :proposal_id]
    change_column :signatures, :user_id, :integer, :null => true
    change_column :signatures, :proposal_id, :integer, :null => true
    
  end
end
