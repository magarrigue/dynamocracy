require 'test_helper'

class ProposalTest < ActiveSupport::TestCase
  
  # Replace this with your real tests.
  test "should not save proposal without proposal" do
    proposal = Factory.build :proposal
    proposal.text = nil
    assert ! proposal.save
  end
  
 test "a proposal belongs to a user" do
    proposal = Factory.build :proposal
    assert  proposal.save
    assert !proposal.user_id.nil?
    assert !proposal.user.nil? 
  end
  
  test "should save proposal a  proposal with a user and a proposal" do
    proposal = Factory :proposal
  end
  
  test "should not save proposal a  proposal without a user" do
    proposal = Proposal.new :text=>"qu on prenne un café à la fraiche cet été"
    assert ! proposal.save
  end
  
  test 'default dates' do
    assert_equal Time.now.to_i, Proposal.new.opening_at.to_i
    assert_equal 7.day.from_now.to_i, Proposal.new.closing_at.to_i
  end
  
  
  
end 
