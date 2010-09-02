class CreateTableCrews < ActiveRecord::Migration
  def self.up
    create_table :crews do |t|
      t.string :name
      t.text :constitution
      t.integer :creator_id 
      t.timestamps
    end
  end

  def self.down
    drop_table :crews
  end
end
