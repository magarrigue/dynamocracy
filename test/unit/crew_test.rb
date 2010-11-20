require 'test_helper'

class CrewTest < ActiveSupport::TestCase
 
 test 'Create crew ' do
    user = Factory.build :user
    assert user.save
    crew = Crew.new(:name=>'test21', :creator_id=>user.id)
    assert crew.save!
    assert_equal user.id, crew.creator_id
    crew = Crew.new(:name=>'test21', :creator_id=>user.id)
    assert crew.save
  end
  
 test 'Creating a crew create an officer membership for the creator' do
    user = Factory.create :user
    assert Membership.user_id_equals(user.id).empty?
    crew = Crew.new(:name=>'test21', :creator_id=>user.id)
    assert crew.save
    assert_equal 1, Membership.user_id_equals(user.id).count
    assert_equal 'officer', Membership.user_id_equals(user.id).first.role
    assert_equal crew.id, Membership.user_id_equals(user.id).first.crew_id
 end
   
 
end

