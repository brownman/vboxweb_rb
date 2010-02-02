# VirtualBox Web Interface (vboxweb_rb)

A recreation of the VirtualBox GUI for the web using Ruby

Very limited features at the moment. See Changelog.md and TODO

## Installation

If you haven't got VirtualBox installed, you'll need that ;-)

Then run the following in a shell console:

    [sudo] gem install rails less virtualbox

Then adjust config/config.yml, changing the username, password and pointing
vboxmanage to the path of the VBoxManage executable on your system

Start the app:

    ruby script/console

Then start using it:

    http://localhost:3000

## Screenshot

![VM Control Interface](http://img.skitch.com/20100131-fpsuekt76kjpxb3k8axsi1amju.jpg "VM Control Interface")

## Credits

* [Vboxweb_rb](http://github.com/KieranP/vboxweb_rb) application written by [Kieran Pilkington](http://github.com/KieranP)
* Utilizes [Virtualbox gem](http://github.com/mitchellh/virtualbox) by [Mitchell Hashimoto](http://github.com/mitchellh)
* Application run using [Rails](http://rubyonrails.org) and [LessCSS](http://lesscss.org/)
* Images from VirtualBox are licensed GPL 2. See public/images/virtualbox/COPYING
