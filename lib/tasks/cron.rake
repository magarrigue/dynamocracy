task :cron => :environment do
   puts "Starting news cron"
   User.find_each do |user|
    puts "News for user #{user.id}"
    if user.newsletter_frequency == 0
      puts  "newsletter disabled for #{user.id}, skipping..."
    else
       if ( user.newsletter_last_sent_at.nil? || user.newsletter_last_sent_at < user.newsletter_frequency.days.ago )
        puts "time has come for news for #{user.id} "
        mailer = NewsMailer.send "new", "news", user
        if mailer.has_news?
          mailer.deliver!
          user.newsletter_last_sent_at = Time.now
          user.save!
          puts "News delivered for #{user.id} "
        else
          if( user.newsletter_last_sent_at.nil?|| user.newsletter_last_sent_at < (10*user.newsletter_frequency).days.ago)
            puts "deliver nothing..."
            mailer.deliver!
            user.newsletter_last_sent_at = Time.now
            user.save!
          else
            puts "No news for #{user.id}, skipping..."
          end
        end     
      else
        puts "not the time for #{user.id} "
      end
     end
   end
   puts "done."
# end
 
end
