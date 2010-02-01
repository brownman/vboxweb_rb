# VirtualBox Web Interface (vboxweb_rb)

A recreation of the VirtualBox GUI for the web using Ruby

Very limited features at the moment. See Changelog.md and TODO

## Installation

If you haven't got VirtualBox installed, you'll need that ;-)

Then run the following in a shell console:

    [sudo] gem install rack rack-flash sinatra less virtualbox

Then configure config.yml, changing the username, password and pointing
vboxmanage to the path of the VBoxManage executable on your system

Start the app:

    ruby vboxweb.rb

Then start using it:

    http://localhost:4567

## Screenshot

![VM Control Interface](http://img.skitch.com/20100131-fpsuekt76kjpxb3k8axsi1amju.jpg "VM Control Interface")

## Credits

* [Vboxweb_rb](http://github.com/KieranP/vboxweb_rb) application written by [Kieran Pilkington](http://github.com/KieranP)
* Utilizes [Virtualbox gem](http://github.com/mitchellh/virtualbox) by [Mitchell Hashimoto](http://github.com/mitchellh)
* Application run using [Sinatra](http://www.sinatrarb.com) and [LessCSS](http://lesscss.org/)
* Images from VirtualBox sre licensed GPL 2. See public/images/virtualbox/COPYING
