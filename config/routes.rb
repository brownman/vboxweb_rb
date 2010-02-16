VboxwebRb::Application.routes.draw do |map|
  match 'vm/:uuid/settings' => 'vm#settings', :as => 'vm_settings'
  match 'vm/:uuid/export'   => 'vm#export',   :as => 'vm_export'
  match 'vm/:uuid/destroy'  => 'vm#destroy',  :as => 'vm_destroy'
  match 'vm/:uuid/:command' => 'vm#control',  :as => 'vm_control'
  match 'vm/:uuid'          => 'vm#show',     :as => 'vm'

  root :to => 'homepage#index'
end
