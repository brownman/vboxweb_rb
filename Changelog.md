# Changelog

## 0.3.0 (unreleased)
* Pushed Virtual Machine export to a background process
    * There is also a nice AJAX updater which displays a progress bar thanks to some recent changes in the VirtualBox gem
* Big layout UI tweaks (get rid of that boxed in feel)

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
