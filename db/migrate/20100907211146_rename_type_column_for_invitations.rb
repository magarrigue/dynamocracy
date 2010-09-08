class RenameTypeColumnForInvitations < ActiveRecord::Migration
  def self.up
    rename_column :invitations, :type, :role
  end

  def self.down
    rename_column :invitations, :role, :type
  end
end
