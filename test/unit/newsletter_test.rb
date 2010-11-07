require 'test_helper'

class NewsLetterTest < ActiveSupport::TestCase
  
  
  test "test that the content of the fucking newsletter contains the user ID, and not user's memory address" do
    user = Factory.build :user
    user.save!  
    assert user != nil, "OMG, factory girl is broken, everything is going to collapse!! "
  
    body = NewsMailer.send("new", "news", user).body
    assert body.include?("id=#{user.id}"), "MAIL STILL NOT CONTAINING ID BUT MEMORY ADDRESS, PLEASE KILL ME, KIIIIILLLLL ME"
  end
  
  
end