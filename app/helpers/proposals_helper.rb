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
  
  def order_proposal(search, options = {}, html_options = {})
      puts params.inspect
      options[:params_scope] ||= :filter
      if !options[:as]
        id = options[:by].to_s.downcase == "id"
        options[:as] = id ? options[:by].to_s.upcase : options[:by].to_s.humanize
      end
      options[:ascend_scope] ||= "ascend_by_#{options[:by]}"
      options[:descend_scope] ||= "descend_by_#{options[:by]}"
      ascending = search.order.to_s == options[:ascend_scope]
      new_scope = ascending ? options[:descend_scope] : options[:ascend_scope]
      selected = [options[:ascend_scope], options[:descend_scope]].include?(search.order.to_s)
      if selected
        css_classes = html_options[:class] ? html_options[:class].split(" ") : []
        if ascending
          options[:as] = "&#9650;&nbsp;#{options[:as]}"
          css_classes << "ascending"
        else
          options[:as] = "&#9660;&nbsp;#{options[:as]}"
          css_classes << "descending"
        end
        html_options[:class] = css_classes.join(" ")
      end
     url_options = {
        options[:params_scope] =>  { :order => new_scope } 
      }.deep_merge(options[:params] || {})

      options[:as] = raw(options[:as]) if defined?(RailsXss)

      link_to options[:as], url_for(url_options), html_options
    end
  
  
end

