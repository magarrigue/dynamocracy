# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper


  def link_to_t i18n_key, opts={}, html_opts={}
    link_to t(i18n_key), opts, html_opts
  end
  
  def date_distance(date)
    return "#{distance_of_time_in_words_to_now date} ago" if Time.now > date
    "in #{distance_of_time_in_words_to_now date}"
  end
  
  def begining(proposal)
    proposal.text[0..35]+"..."
  end
  
 

end
