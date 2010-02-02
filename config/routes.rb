ActionController::Routing::Routes.draw do |map|
  map.connect '/vm/:uuid', :controller => 'vm', :action => 'show'
  map.connect '/vm/:uuid/:command', :controller => 'vm', :action => 'execute'
  map.root :controller => "homepage"
end
