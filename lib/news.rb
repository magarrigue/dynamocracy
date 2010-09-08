module News
 def fetch_news_for_user(user,since=nil)
      @since||=user.newsletter_frequency
      since=@since.days.ago
      @new_unvoteds = ((Proposal.accessible(user.id).ongoing.updated_at_after(since)+
      Proposal.accessible(user.id).ongoing.signatures_count_equals(0).updated_at_after(since))-Proposal.accessible(user.id).ongoing.updated_at_after(since).voted(user.id)).uniq
      @new_decisions = Proposal.accessible(user.id).decision.updated_at_after(since).uniq
      @new_members = Membership.accessible(user.id).updated_at_after(since).uniq
      @new_votes = Proposal.accessible(user.id).user_id_equals(user.id).votes_created_at_after(since).uniq
 end
end

