class DropOpenId < ActiveRecord::Migration

  def self.up
    drop_table "open_id_associations"
    drop_table "open_id_nonces"
  end


  def self.down
    create_table "open_id_associations" do |t|
      t.column "server_url", :binary, :null => false
      t.column "handle", :string, :null => false
      t.column "secret", :binary, :null => false
      t.column "issued", :integer, :null => false
      t.column "lifetime", :integer, :null => false
      t.column "assoc_type", :string, :null => false
    end

    create_table "open_id_nonces" do |t|
      t.column :server_url, :string, :null => false
      t.column :timestamp, :integer, :null => false
      t.column :salt, :string, :null => false
    end
  end

end
