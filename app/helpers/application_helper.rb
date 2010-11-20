# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper


  def date_distance(date)
    return "#{distance_of_time_in_words_to_now date} ago" if Time.now > date
    "in #{distance_of_time_in_words_to_now date}"
  end

  def member_proposal_contribution_score(membership)  
    proposals = Proposal.user_id_equals(membership.user_id).crew_id_equals(membership.crew_id)
    score = 0
    proposals.each{|p| score += p.yes_count+p.support_count}
    score
  end
 

end
