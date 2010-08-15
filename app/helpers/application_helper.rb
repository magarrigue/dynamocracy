# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper


  def link_to_t i18n_key, opts={}, html_opts={}
    link_to t(i18n_key), opts, html_opts
  end
end
