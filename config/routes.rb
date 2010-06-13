VboxwebRb::Application.routes.draw do |map|
  match 'vm/imports'              => 'import#index',    :as => 'vm_imports'
  match 'vm/imports/new'          => 'import#new',      :as => 'vm_new_import'
  match 'vm/imports/upload'       => 'import#upload',   :as => 'vm_upload_import'
  match 'vm/imports/:id/progress' => 'import#progress', :as => 'vm_import_progress'
  match 'vm/imports/:id/destroy'  => 'import#destroy',  :as => 'vm_import_destroy'
  match 'vm/imports/:id'          => 'import#show',     :as => 'vm_import'
  
  match 'vm/:uuid/exports'              => 'export#index',    :as => 'vm_exports'
  match 'vm/:uuid/exports/new'          => 'export#new',      :as => 'vm_new_export'
  match 'vm/:uuid/exports/:id/progress' => 'export#progress', :as => 'vm_export_progress'
  match 'vm/:uuid/exports/:id/download' => 'export#download', :as => 'vm_export_download'
  match 'vm/:uuid/exports/:id/destroy'  => 'export#destroy',  :as => 'vm_export_destroy'
  match 'vm/:uuid/exports/:id'          => 'export#show',     :as => 'vm_export'

  match 'vm/:uuid/snapshots'             => 'snapshots#index',   :as => 'vm_snapshots'
  match 'vm/:uuid/snapshots/new'         => 'snapshots#new',     :as => 'vm_new_snapshot'
  match 'vm/:uuid/snapshots/:id/restore' => 'snapshots#restore', :as => 'vm_snapshot_restore'
  match 'vm/:uuid/snapshots/:id/destroy' => 'snapshots#destroy', :as => 'vm_snapshot_destroy'
  match 'vm/:uuid/snapshots/:id'         => 'snapshots#show',    :as => 'vm_snapshot'

  match 'vm/:uuid/settings' => 'vm#settings', :as => 'vm_settings'
  match 'vm/:uuid/destroy'  => 'vm#destroy',  :as => 'vm_destroy'
  match 'vm/:uuid/:command' => 'vm#control',  :as => 'vm_control'
  match 'vm/:uuid'          => 'vm#show',     :as => 'vm'

  match 'hd/:uuid/release' => 'hd#release', :as => 'hd_release'
  match 'hd/:uuid/remove'  => 'hd#remove',  :as => 'hd_remove'
  match 'hd/:uuid'         => 'hd#show',    :as => 'hd'

  root :to => 'homepage#index'
end
