# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper


  def date_distance(date)
    return "#{distance_of_time_in_words_to_now date} ago" if Time.now > date
    "in #{distance_of_time_in_words_to_now date}"
  end

 

end
