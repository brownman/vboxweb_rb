APP_CONFIG = YAML.load(IO.read(File.join(Rails.root, 'config', 'config.yml')))
VirtualBox::Command.vboxmanage = APP_CONFIG['vboxmanage'] unless APP_CONFIG['vboxmanage'].blank?
VirtualBox::Global.vboxconfig = APP_CONFIG['vboxconfig'] unless APP_CONFIG['vboxconfig'].blank?
