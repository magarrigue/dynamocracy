module News

 def fetch_news_for_user(user,since=nil)
      @since||=user.newsletter_frequency.days.ago
      @since =[@since, user.newsletter_last_sent_at].min if user.newsletter_last_sent_at
      since=@since
      @new_unvoteds = ((Proposal.accessible(user.id).ongoing.updated_at_after(@since)+
      Proposal.accessible(user.id).ongoing.signatures_count_equals(0).updated_at_after(@since))-Proposal.accessible(user.id).ongoing.updated_at_after(@since).voted(user.id)).uniq
      @new_decisions = Proposal.accessible(user.id).decision.updated_at_after(@since).uniq
      @new_members = Membership.accessible(user.id).updated_at_after(@since).uniq
      @new_votes = Proposal.accessible(user.id).user_id_equals(user.id).votes_created_at_after(@since).uniq
      @has_news=has_news?
 end
 
 def has_news?
   ! [@new_members, @new_votes, @new_decisions, @new_unvoteds].all?{|i| i.empty?}
 end
end
