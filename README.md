# VirtualBox Web Interface (vboxweb_rb)

A recreation of the VirtualBox GUI for the web using Ruby

Very limited features at the moment. See Changelog.md and TODO

## Installation

If you haven't got VirtualBox installed, you'll need that ;-)

Then run the following in a shell console:

    $ [sudo] gem install bundler
    $ git clone git://github.com/KieranP/vboxweb_rb.git
    $ cd vboxweb_rb
    $ bundle install
    $ script/delayed_job start

Then adjust config/config.yml, changing the username and password.

Start the app:

    ruby script/rails server

Then start using it:

    http://localhost:3000

## Screenshot

### Interface for a powered off Virtual Machine
![](http://img.skitch.com/20100416-m19ij3i79hawpb9xrx6t1mch2g.png)

### Interface for a Hard Drive
![](http://img.skitch.com/20100416-jk38y91qbrma6rbehxqyg5kbsc.png)

## Credits

* [Vboxweb_rb](http://github.com/KieranP/vboxweb_rb) application written by [Kieran Pilkington](http://github.com/KieranP)
* Utilizes [Virtualbox gem](http://github.com/mitchellh/virtualbox) by [Mitchell Hashimoto](http://github.com/mitchellh)
* Application run using [Rails](http://rubyonrails.org) and [LessCSS](http://lesscss.org/)
* Images from VirtualBox are licensed GPL 2. See public/images/virtualbox/COPYING
