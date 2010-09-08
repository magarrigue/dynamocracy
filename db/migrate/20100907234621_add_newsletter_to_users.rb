class AddNewsletterToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :newsletter_frequency, :integer, :default=>7
    add_column :users, :newsletter_last_sent_at, :datetime
  end

  def self.down
    remove_column :users, :newsletter_last_sent_at
    remove_column :users, :newsletter_frequency
  end
end
