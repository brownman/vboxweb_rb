# Changelog

## 0.3.0 (unreleased)
* Big layout UI tweaks (get rid of that boxed in feel)
* Snapshots (view, create, restore, destroy)
* Release and Remove Hard Drives
* Pushed Virtual Machine export to a background process. This adds an extra installation step. Please see README.rdoc There is also a nice AJAX updater which displays a progress bar thanks to some recent changes in the VirtualBox gem that make it possible to get the current progress.
* Added an Import functionality that uses the same progress update as Export
* Added ability to remove exports or imports from the application using a delete link
* Added ability to download exported Virtual Machines to a Vagrant compatible box file
* Added a couple more Virtual Machine settings to the display page and restore some removed in 0.2.0
* Added tooltips to the Virtual Machine edit settings page labels (hover over "Name" to see what you need to put there)
* Fixed a bug that left the Virtual Machine controls panel blank right after starting the machine
* Able to pass in additional settings to a VM export again
* Support for Rails 3 Beta 4
* Big internal code cleanup

## 0.2.0
* Using mongrel as the application server (was webrick)
* Support for Rails 3 Beta 3
* Support for the Virtualbox Gem 0.6.0
    * As a result of this, some functionality on the settings and export pages has been removed until the VirtualBox gem supports these again
* Virtual Machine Show page UI update (tabs to reduce page height)
* Hard Drive list in the sidebar
* Hard Drive show page, with info like size, and which Virtual Machines are use it

## 0.1.0
* Initial Release
    * View Virtual Machines listed in the sidebar, along with their type and status
    * Access detailed information about Virtual Machines, including:
        * name & os type
        * base & video memory
        * processors
        * network adapters
    * Ability to control a Virtual Machine, including:
        * starting / stopping
        * pausing / resuming
        * save / discarding
        * exporting
        * deleting
    * Ability to edit various Virtual Machines settings
