class ChangeProposalsStatusDefault < ActiveRecord::Migration
  def self.up
      change_column :proposals, :status, :string, :null => false, :default => 'open'
  
  end

  def self.down
    change_column_default(:proposals, :status, nil)
  end
end
