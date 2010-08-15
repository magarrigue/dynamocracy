require 'test_helper'

class VotesTest < ActionController::IntegrationTest

  def setup
    user = Factory :user
    VotesController.any_instance.stubs(:authenticate).returns true
    VotesController.any_instance.stubs(:current_user).returns user
  end

  test "cannot vote on a proposal that is not open" do
    proposal = Factory :proposal, :opening_at => 2.days.from_now
    visit new_proposal_vote_path(proposal)
    choose 'yes'
    assert_no_difference 'Signature.count' do
      click_button 'Vote!'
    end
    assert_not_contain 'Show vote'
  end
  
  test "cannot vote no on a proposal without a comment " do
    proposal = Factory :proposal, :opening_at => 2.days.from_now
    visit new_proposal_vote_path(proposal)
    choose 'no'
    assert_no_difference 'Signature.count' do
      click_button 'Vote!'
    end
  end

#  test "can vote no on a proposal with a comment " do  
#    proposal = Factory :proposal, :opening_at => 2.days.from_now  
#    visit new_proposal_vote_path(proposal)
#    assert_not_contain 'Show vote'
#    fill_in 'value', :with => 'yes'
#    fill_in 'Comment', :with => 'a comment'
#    assert_difference 'Signature.count' do
#      click_button 'Create Vote'
#    end  
#  end
#  
  test "can vote on a proposal that is open" do
    proposal = Factory :proposal, :opening_at => 2.days.ago
    visit new_proposal_vote_path(proposal)
    choose 'yes'
    assert_difference 'Signature.count' do
      click_button 'Vote!'
    end
    assert_contain 'You voted for this proposal'
  end
  
end
