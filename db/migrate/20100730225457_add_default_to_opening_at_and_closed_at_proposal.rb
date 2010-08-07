class AddDefaultToOpeningAtAndClosedAtProposal < ActiveRecord::Migration
  def self.up
    change_column :proposals, :opening_at, :datetime, :null => false, :default => Time.now
    change_column :proposals, :closing_at, :datetime, :null => false, :default => 7.day.from_now
  end

  def self.down
    change_column_default(:proposals, :opening_at, nil)
    change_column_default(:proposals, :closing_at, nil)
  end
end
