class RemovePassCountFromProposals < ActiveRecord::Migration
  def self.up
    remove_column :proposals , :pass_count
  end

  def self.down
    add_column :proposals, :pass_count
  end
end
