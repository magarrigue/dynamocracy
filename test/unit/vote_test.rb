require 'test_helper'

class VoteTest < ActiveSupport::TestCase


  test "a yes with proposal is saved" do
    voted=Factory.build :vote
    assert voted.save!
  end

  test "a support or a pass with proposal is saved" do
    
    ["pass","support"].each do |v|
      voted=Factory.build :vote
      voted.value=v
      assert voted.save
    end
  end
  
  test "a no needs a comment" do
    voted=Factory.build :vote
    voted.value="no"
    assert ! voted.save
    voted.comment = "Pastille verte mec, pastille verte"
    assert voted.save
  end
  
  test 'a veto save the voter' do
    voted=Factory.build :vote
    voted.value='veto'
    assert voted.save
    assert !voted.voter_id.nil?
  end
  
   
  test 'dont vote crap boy' do
    voted=Factory.build :vote
    voted.value='crap'
    assert ! voted.save
  end
  
  test 'cant vote expired' do
    expired = Factory.create(:proposal,:opening_at=>Time.now, :closing_at=>Time.now.in(0.1))
    sleep(0.1)
    vote = expired.votes.create
    vote.voter_id = Factory(:user).id
    vote.value = 'yes'
    assert !vote.save
 end 

  test 'cant vote withdrawn or cancelled' do
    %w(withdrawn cancelled).each do |s|
      proposal = Factory :proposal
      proposal.status=s
      proposal.save!
      vote = proposal.votes.create
      vote.voter_id = Factory(:user).id
      vote.value = 'yes'
      assert ! vote.save
    end
  end

  test 'vote only once' do
    proposal = Factory :proposal
    assert proposal.signatures.empty?
    vote = Factory(:vote, :proposal => proposal)
    assert ! proposal.reload.signatures.empty?
    vote = Factory.build(:vote, :proposal => proposal)
    assert vote.id.nil?
    assert !vote.save
  end
  
  test 'vote support pass' do
    %w(support pass).each do |v|
      vote = Factory.build(:vote, :value=>v)
      assert vote.save
    end
    
  end
  
  
  test 'vote no needs a comment' do
    vote = Factory.build(:vote, :value=>'no')
    assert !vote.save
    vote.comment = "a small comment"
    assert vote.save
  end
  
  
  test 'assert vote is anonymous' do
    %w(support pass yes no).each do |v|
      vote = Factory(:vote, :value=>v, :comment=>'for no case')
      assert vote.voter_id.nil?
    end
  end
  
  test 'assert vote veto is claimed and vote is cancelled' do
    vote = Factory(:vote, :value=>'veto', :comment=>'for no case')
    assert !vote.voter_id.nil?
    assert 'cancelled', vote.proposal.status
  end

  
end
