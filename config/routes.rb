VboxwebRb::Application.routes.draw do |map|
  match 'vm/:uuid/:command', :to => 'vm#execute'
  match 'vm/:uuid', :to => 'vm#show'

  root :to => 'homepage#index'
end
