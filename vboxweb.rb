require 'rubygems'
require 'sinatra'
require 'erb'
require 'less'

require 'rack-flash'
require 'rack/utils'

require 'virtualbox'

require 'actions'
require 'helpers'

def configuration
  @@configuration ||= YAML.load(IO.read(File.join(File.dirname(__FILE__), 'config.yml')))
end

use Rack::Auth::Basic do |username, password|
  [username, password] == [configuration['username'], configuration['password']]
end

# flash[] support
set :sessions, true
use Rack::Flash

configure do
  VirtualBox::Command.vboxmanage = configuration['vboxmanage']

  Dir['public/css/*.less'].each do |less_file|
    css_path = less_file.gsub('.less', '.css')
    less_contents = File.read(less_file)
    css = Less::Engine.new(less_contents).to_css
    File.open(css_path, 'w') do |f|
      f.puts css
    end
  end
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
  include VBoxWeb::Helpers
end
