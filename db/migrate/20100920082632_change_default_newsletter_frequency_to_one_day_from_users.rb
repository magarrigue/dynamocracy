class ChangeDefaultNewsletterFrequencyToOneDayFromUsers < ActiveRecord::Migration
  def self.up
    change_column_default(:users, :newsletter_frequency, 1)
    User.find(:all).each { |user| (user.newsletter_frequency = 1; user.save) if user.newsletter_frequency == 7  }
  end

  def self.down
    change_column_default(:users, :newsletter_frequency, 7)
  end
end
