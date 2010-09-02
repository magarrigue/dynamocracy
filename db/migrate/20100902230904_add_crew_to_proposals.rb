class AddCrewToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :crew_id, :integer, :null=>false, :default=>-1
    change_column_default(:proposals, :crew_id, nil)
  end

  def self.down
    remove_column :proposals, :crew_id
  end
end
