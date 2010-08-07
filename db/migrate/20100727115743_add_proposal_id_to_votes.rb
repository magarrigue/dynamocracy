class AddProposalIdToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :proposal_id, :integer
  end

  def self.down
    remove_column :votes, :proposal_id
  end
end
