class AddProposalCommentTypeColumnToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :public_comments_allowed, :boolean, :default=>true, :null=>false
    Proposal.find_each{|p| p.public_comments_allowed=false; p.save false;}
  end

  def self.down
    remove_column :proposals, :public_comments_allowed
  end
end
