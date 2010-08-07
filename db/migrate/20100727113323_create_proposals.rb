class CreateProposals < ActiveRecord::Migration
  def self.up
    create_table :proposals do |t|
      t.text :text
      t.string :status
      t.datetime :opening_at
      t.datetime :closing_at

      t.timestamps
    end
  end

  def self.down
    drop_table :proposals
  end
end
