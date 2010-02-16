# VirtualBox Web Interface (vboxweb_rb)

A recreation of the VirtualBox GUI for the web using Ruby

Very limited features at the moment. See Changelog.md and TODO

## Installation

If you haven't got VirtualBox installed, you'll need that ;-)

Then run the following in a shell console:

    $ [sudo] gem install bundler less
    $ git clone git://github.com/KieranP/vboxweb_rb.git
    $ cd vboxweb_rb
    $ bundle install
    $ script/generate_stylesheets

Then adjust config/config.yml, changing the username, password and pointing
vboxmanage to the path of the VBoxManage executable on your system

Start the app:

    ruby script/rails server

Then start using it:

    http://localhost:3000

## Screenshot

### Interface for a powered off Virtual Machine
![](http://img.skitch.com/20100216-k84yhtc299xnf9sd494tc9qqh4.jpg)

### Interface for a running Virtual Machine
![](http://img.skitch.com/20100216-th4a99yf5mycss2r1u4kj1tqp.jpg)

## Credits

* [Vboxweb_rb](http://github.com/KieranP/vboxweb_rb) application written by [Kieran Pilkington](http://github.com/KieranP)
* Utilizes [Virtualbox gem](http://github.com/mitchellh/virtualbox) by [Mitchell Hashimoto](http://github.com/mitchellh)
* Application run using [Rails](http://rubyonrails.org) and [LessCSS](http://lesscss.org/)
* Images from VirtualBox are licensed GPL 2. See public/images/virtualbox/COPYING
