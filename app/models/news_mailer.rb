class NewsMailer < ActionMailer::Base
  include News
   def news(user)
      recipients user.email
      from "no-reply@#{ENV['host']}"
      subject "News from your Dynamocracy crews : #{Time.now}"
      fetch_news_for_user(user)
      @user = user
   end


end
