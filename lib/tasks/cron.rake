task :cron => :environment do
   puts "Starting news cron"
   User.find_each do |user|
    puts "News for user #{user.id}"
    if user.newsletter_frequency>0 && user.newsletter_last_sent_at.nil? || user.newsletter_last_sent_at < user.newsletter_frequency.days.ago
      puts "time has come for news for #{user.id} "
      NewsMailer.deliver_news(user)
      
      puts "News delivered for #{user.id} "
      user.newsletter_last_sent_at = Time.now
      user.save!
    else
      puts "not the time for #{user.id} "
    end
   end
   puts "done."
# end
 
end
