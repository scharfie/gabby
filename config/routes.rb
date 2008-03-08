ActionController::Routing::Routes.draw do |map|
  map.connect 'stylesheets/:action.:format', :controller => 'stylesheets'
    
  map.resources :users
  map.resource :session

  map.connect 'gabber/:action/:id', :controller => 'gabber'

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.root :controller => 'chat'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
