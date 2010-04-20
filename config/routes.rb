VboxwebRb::Application.routes.draw do |map|
  match 'vm/:uuid/exports'              => 'export#index',    :as => 'vm_exports'
  match 'vm/:uuid/exports/new'          => 'export#new',      :as => 'vm_new_export'
  match 'vm/:uuid/exports/:id/progress' => 'export#progress', :as => 'vm_export_progress'
  match 'vm/:uuid/exports/:id/download' => 'export#download', :as => 'vm_export_download'
  match 'vm/:uuid/exports/:id'          => 'export#show',     :as => 'vm_export'

  match 'vm/:uuid/settings' => 'vm#settings', :as => 'vm_settings'
  match 'vm/:uuid/destroy'  => 'vm#destroy',  :as => 'vm_destroy'
  match 'vm/:uuid/:command' => 'vm#control',  :as => 'vm_control'
  match 'vm/:uuid'          => 'vm#show',     :as => 'vm'

  match 'hd/:uuid/release' => 'hd#release', :as => 'hd_release'
  match 'hd/:uuid/remove'  => 'hd#remove',  :as => 'hd_remove'
  match 'hd/:uuid'         => 'hd#show',    :as => 'hd'

  root :to => 'homepage#index'
end
