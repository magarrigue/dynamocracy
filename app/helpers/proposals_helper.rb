module ProposalsHelper
  def mine?(proposal)
    proposal.user_id == current_user.id
  end
  
  def withdrawable?(proposal)
      mine?(proposal) && (proposal.full_status == 'open' || proposal.full_status == 'pending')
  end
  
  def votable?(proposal)
    proposal.full_status == 'open' && @my_signatures.find_all{|s| s.proposal_id==proposal.id}.empty?
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
 
  def comments_by_vote_value(proposal)
    comments_map = {:negative=>[], :positive=>[], :neutral=>[]}
    proposal.votes.each do |v|
      if !v.comment.empty?
        comments_map[:neutral].push v.comment if v.value =='pass'
        comments_map[:positive].push v.comment if %w(yes support).include? v.value
        comments_map[:negative].push v.comment if %w(no veto).include?  v.value
       end
    end
    comments_map
  end
  
  
  
end

