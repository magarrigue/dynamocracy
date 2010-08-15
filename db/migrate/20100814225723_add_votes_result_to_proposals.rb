class AddVotesResultToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :yes_count,      :integer, :default=>0
    add_column :proposals, :no_count,       :integer, :default=>0
    add_column :proposals, :support_count,  :integer, :default=>0
    add_column :proposals, :pass_count,     :integer, :default=>0
  end

  def self.down
    remove_column :proposals, :yes_count  
    remove_column :proposals, :no_count    
    remove_column :proposals, :support_count
    remove_column :proposals, :pass_count 
  end
end
