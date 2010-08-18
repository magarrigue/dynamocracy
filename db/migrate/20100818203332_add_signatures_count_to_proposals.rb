class AddSignaturesCountToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :signatures_count, :integer, :default => 0
  end

  def self.down
    remove_column :proposals, :signatures_count
  end
end
