require 'test_helper'

class AbilityTest < ActiveSupport::TestCase


  test 'user can only create crew' do
    user = Factory.build :user
    ability = Ability.new(user)
    assert ability.can?(:create, Crew)  
    assert ability.cannot?(:read, Crew)  
    assert ability.cannot?(:update, Crew)
    assert ability.cannot?(:destroy, Crew)        
  end
  
  test 'crewman can only read crew' do
    creator = Factory.create :user
    crewman = Factory.create :user
    crew = Crew.new(:name=>'test21', :creator_id=>creator.id)
    crew.save!
    m = Membership.new(:crew_id=>crew.id, :user_id=>crewman.id,:role=>'crewman')
    m.save!
    creator_ability = Ability.new(creator)
    crewman_ability = Ability.new(crewman)
    assert crewman_ability.can?(:read,crew)
    assert crewman_ability.cannot?(:update,crew)
    assert crewman_ability.cannot?(:destroy,crew)
  end

  test 'officer can read and update crew' do
    creator = Factory.create :user
    admin = Factory.create :user
    crew = Crew.new(:name=>'test21', :creator_id=>creator.id)
    crew.save!
    m = Membership.new(:crew_id=>crew.id, :user_id=>admin.id,:role=>'officer')
    m.save!
    admin_ability = Ability.new(admin)
    assert admin_ability.can?(:read,crew)
    assert admin_ability.can?(:update,crew)
    assert admin_ability.cannot?(:destroy,crew)
  end
  
  
  test 'crewman and officer can only create mine and read proposal of their crew, and update their own' do
    creator = Factory.create :user
    creator_2 = Factory.create :user
    admin = Factory.create :user
    crewman = Factory.create :user
    crew = Crew.new(:name=>'test21', :creator_id=>creator.id)
    crew_2 = Crew.new(:name=>'37', :creator_id=>creator_2.id)
    crew.save!
    crew_2.save!
    Membership.new(:crew_id=>crew.id, :user_id=>crewman.id,:role=>'crewman').save!
    Membership.new(:crew_id=>crew.id, :user_id=>admin.id,:role=>'officer').save!

    admin_ability = Ability.new(admin)
    crewman_ability = Ability.new(crewman)

    proposal = Factory.create :proposal, :crew_id => crew.id
    proposal_2 = Factory.create :proposal, :crew_id => crew_2.id    
    my_proposal = Factory.create :proposal, :crew_id => crew.id, :user_id=>crewman.id    
    
    assert crewman_ability.can?(:create, my_proposal)
    assert crewman_ability.can?(:create, proposal)
    assert crewman_ability.cannot?(:create, proposal_2)
    assert admin_ability.cannot?(:create, proposal_2)
    
    assert admin_ability.can?(:read,proposal)
    assert crewman_ability.can?(:read,proposal)
    assert admin_ability.can?(:update,proposal)
    assert crewman_ability.can?(:update,proposal)
    assert admin_ability.cannot?(:destroy,proposal)
    assert crewman_ability.cannot?(:destroy,proposal)    
    
    
    
    assert admin_ability.cannot?(:read,proposal_2)
    assert crewman_ability.cannot?(:read,proposal_2)
    assert admin_ability.cannot?(:update,proposal_2)
    assert crewman_ability.cannot?(:update,proposal_2)
    assert admin_ability.cannot?(:destroy,proposal_2)
    assert crewman_ability.cannot?(:destroy,proposal_2)    
    
    
    assert crewman_ability.can?(:read,my_proposal)
    assert crewman_ability.can?(:update,my_proposal)
    assert crewman_ability.can?(:destroy,my_proposal)    
  end
  
  test 'officer can manage invitation their crew' do
    creator = Factory.create :user
    creator_2 = Factory.create :user

    admin = Factory.create :user
    admin_bis = Factory.create :user

    admin_2 = Factory.create :user

    crew = Crew.new(:name=>'test21', :creator_id=>creator.id)
    crew_2 = Crew.new(:name=>'37', :creator_id=>creator_2.id)

    crew.save!
    crew_2.save!

    admin_membership = Membership.new(:crew_id=>crew.id, :user_id=>admin.id,:role=>'officer')
    admin_bis_membership = Membership.new(:crew_id=>crew.id, :user_id=>admin_bis.id,:role=>'officer')
    
    admin_2_membership = Membership.new(:crew_id=>crew_2.id, :user_id=>admin_2.id,:role=>'officer')

    admin_membership.save!
    admin_bis_membership.save!
    admin_2_membership.save!

    admin_ability = Ability.new(admin)
    
    admin_i = Invitation.new(:crew_id=>crew.id, :user_id=>admin.id, :email=>"atot@tt.com")
    admin_bis_i = Invitation.new(:crew_id=>crew.id, :user_id=>admin_bis.id, :email=>"atoat@tt.com")

    admin_2_i = Invitation.new(:crew_id=>crew_2.id, :user_id=>admin_2.id, :email=>"atot@tt.com")
    

    assert admin_ability.cannot?(:read,admin_2_i)
    assert admin_ability.can?(:manage,admin_i)
    assert admin_ability.can?(:manage,admin_bis_i)
    assert admin_ability.cannot?(:manage,admin_2_i)
    
  end
  
  
end
