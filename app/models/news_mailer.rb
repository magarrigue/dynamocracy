class NewsMailer < ActionMailer::Base
  include News
   def news(user)
      recipients user.email
      from "#{ENV['CREW']||'Dynamocracy'} News <no-reply@#{ENV['host']}>"
      subject "News from your #{ENV['CREW']||'Dynamocracy'} crews : #{Time.now.ctime}"
      fetch_news_for_user(user)
      @user = user
      content_type "text/html"
   end
end
