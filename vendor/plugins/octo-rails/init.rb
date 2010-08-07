config.gem 'haml'
config.gem 'ruby-openid', :lib => false
config.gem 'rack-openid', :lib => 'rack/openid'
config.gem 'formtastic'

require 'openid_ar_store'

ActionController::Base.send :include, OctoRails

config.after_initialize do
  Haml.init_rails(binding) if defined?(Haml)
end
