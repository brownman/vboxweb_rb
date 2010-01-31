# VirtualBox Web Interface

A recreation of the VirtualBox GUI for the web

Very limited features at the moment. See Changelog.md and TODO

Uses the awesome [VirtualBox](http://github.com/mitchellh/virtualbox) gem

## Installation

If you haven't got VirtualBox installed, you'll need that ;-)

Then run the following in a shell console:

    [sudo] gem install rack rack-flash sinatra less virtualbox

Then configure config.yml, changing the username, password and pointing
vboxmanage to the path of the VBoxManage executable on your system

Then start the app:

    ruby virtualbox_web.rb
