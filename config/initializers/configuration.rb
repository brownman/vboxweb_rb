APP_CONFIG = YAML.load(IO.read(File.join(Rails.root, 'config', 'config.yml')))
VirtualBox::Command.vboxmanage = APP_CONFIG['vboxmanage']
