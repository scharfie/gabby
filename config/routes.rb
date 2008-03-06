ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'chat'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
