# This file is used by Rack-based servers to start the application.
require ::File.join(File.dirname(__FILE__), 'vboxweb')
run VBoxWeb::Application
