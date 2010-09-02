class AddPassCountToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :pass_count, :integer, :default=>0
  end

  def self.down
    remove_column :proposals, :pass_count
  end
end
