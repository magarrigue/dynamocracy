class Vote < ActiveRecord::Base

  attr_accessible :voter_id, :value, :comment
  
  belongs_to :proposal
  validates_presence_of :proposal, :value, :voter_id
 
  validates_inclusion_of :value, :in => %w(yes support no veto pass), :message => "{{value}} is not a valid vote"
  validates_presence_of :comment, :if => :no?
  
  validate :open_proposal?
  validate :not_closed_proposal?
  validate :hasnt_voted_yet?
  validate :not_cancelled_proposal?
  validate :not_withdrawn_proposal?
  
  before_create :create_signature  
  before_create :remove_voter, :unless => :veto?
  after_create :cancel_proposal!, :if => :veto?
  after_create :update_proposal_votes
  #attr_accessor :voter_id
  
  def open_proposal?
    errors.add_to_base 'This proposal is not open yet' if proposal.opening_at > Time.now
  end
  
  def not_closed_proposal?
    errors.add_to_base 'This proposal is closed' if proposal.closing_at < Time.now
  end
  
  def not_cancelled_proposal?
    errors.add_to_base 'This proposal has been cancelled' if proposal.status=='cancelled'
  end
  
  def not_withdrawn_proposal?
    errors.add_to_base 'This proposal has been withdrawn' if proposal.status=='withdrawn'
  end
  
  def create_signature
    Signature.create :user_id => voter_id, :proposal_id => proposal_id
  end
  
  
  def update_proposal_votes
    proposal["#{value}_count".to_sym] += 1  unless value=='veto' 
  end
  
  
  def hasnt_voted_yet?
   errors.add_to_base 'already voted this proposal' if Signature.exists? :user_id => voter_id, :proposal_id => proposal_id
  end
  
  def cancel_proposal!
    proposal.status ='cancelled'
  end
  
  def veto?
    value=='veto'
  end
  def no?
    value=='no'
  end
  
  def remove_voter
    self.voter_id=nil 
    true
  end
end
