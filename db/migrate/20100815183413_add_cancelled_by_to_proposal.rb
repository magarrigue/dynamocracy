class AddCancelledByToProposal < ActiveRecord::Migration
  def self.up
   add_column :proposals, :cancelled_by_id,      :integer, :null=> true
   remove_column  :votes , :voter_id
  end

  def self.down
    remove_column :proposals, :cancelled_by_id
    add_column :votes, :voter_id, :integer
  end
end
