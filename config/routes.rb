ActionController::Routing::Routes.draw do |map|
  map.resources :users

  map.resource :session

  map.root :controller => 'chat'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
