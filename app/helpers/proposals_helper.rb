module ProposalsHelper
  def mine?(proposal)
    proposal.user_id == current_user.id
  end
  
  def withdrawable?(proposal)
      mine?(proposal) && (proposal.full_status == 'open' || proposal.full_status == 'pending')
  end
  
  def votable?(proposal)
    proposal.full_status == 'open' && @my_signatures.none?{|s| s.proposal_id==proposal.id}
  end
  
  def actionable?(proposal)
    withdrawable?(proposal) || votable?(proposal) 
  end
  
  
  def result?(proposal)
  %w(closed cancelled).include?(proposal.full_status)
  end
  
  def results?
   @proposals.any?{|p| result? p } 
  end
  def actionables?
   @proposals.any?{|p|actionable?(p)}
  end
 
  
end

