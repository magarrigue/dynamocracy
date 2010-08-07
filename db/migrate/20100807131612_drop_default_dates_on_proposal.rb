class DropDefaultDatesOnProposal < ActiveRecord::Migration
  
  def self.up
    change_column_default(:proposals, :opening_at, nil)
    change_column_default(:proposals, :closing_at, nil)
  end
  
  def self.down
    change_column :proposals, :opening_at, :datetime, :null => false, :default => (Time.now).to_s(:db)
    change_column :proposals, :closing_at, :datetime, :null => false, :default => (Time.now + 1.week).to_s(:db)
  end

  
end
