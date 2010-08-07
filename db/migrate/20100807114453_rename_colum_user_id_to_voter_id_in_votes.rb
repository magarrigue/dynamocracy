class RenameColumUserIdToVoterIdInVotes < ActiveRecord::Migration
  def self.up
    rename_column :votes, :user_id, :voter_id

  end

  def self.down
        rename_column :votes, :voter_id, :user_id
  end
end
