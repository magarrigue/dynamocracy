ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'logout'
  map.login '/login', :controller => 'sessions', :action => 'new'
end