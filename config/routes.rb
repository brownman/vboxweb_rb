VboxwebRb::Application.routes.draw do |map|
  match 'vm/:uuid/destroy'  => 'vm#destroy', :as => 'destroy_vm'
  match 'vm/:uuid/:command' => 'vm#control', :as => 'control_vm'
  match 'vm/:uuid'          => 'vm#show',    :as => 'vm'

  root :to => 'homepage#index'
end
