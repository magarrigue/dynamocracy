class CreateTableInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.integer :crew_id
      t.integer :user_id
      t.string :email
      t.datetime :sent_at
      t.datetime :expire_at
      t.datetime :validated_at
      t.string :invitation_token
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
