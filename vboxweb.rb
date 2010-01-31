require 'rubygems'
require 'sinatra'
require 'erb'
require 'less'
require 'virtualbox'

helpers do

  require 'rack/utils'
  include Rack::Utils
  alias_method :h, :escape_html

  require 'helpers/drives'
  require 'helpers/general'
  require 'helpers/vms'

end

@configuration = YAML.load(IO.read(File.join(File.dirname(__FILE__), 'config.yml')))
VirtualBox::Command.vboxmanage = @configuration['vboxmanage']

use Rack::Auth::Basic do |username, password|
  [username, password] == [@configuration['username'], @configuration['password']]
end

# flash[] support
set :sessions, true
require 'rack-flash'
use Rack::Flash

configure do
  Dir['public/css/*.less'].each do |less_file|
    css_path = less_file.gsub('.less', '.css')
    less_contents = File.read(less_file)
    css = Less::Engine.new(less_contents).to_css
    File.open(css_path, 'w') do |f|
      f.puts css
    end
  end
end

get "/" do
  erb :index, :layout => :application
end

get "/vm/:uuid" do
  @vm = VirtualBox::VM.find(params[:uuid])
  erb :vm, :layout => :application
end

get "/vm/:uuid/:action" do
  @vm = VirtualBox::VM.find(params[:uuid])

  case params[:action]
  when 'start'
    @vm.start(:headless, true)
    flash[:notice] = "#{@vm.name} has been started, but give it a minute to fully boot."
  when 'shutdown'
    @vm.shutdown(true)
    flash[:notice] = "#{@vm.name} is being shutdown. Please wait a bit for it to complete and refresh the page."
  when 'poweroff'
    @vm.stop(true)
    flash[:notice] = "#{@vm.name} has been powered off. Any unsaved data will have been lost."
  when 'pause'
    @vm.pause(true)
    flash[:notice] = "#{@vm.name} has been paused."
  when 'resume'
    @vm.resume(true)
    flash[:notice] = "#{@vm.name} has been resumed."
  when 'save'
    @vm.save_state(true)
    flash[:notice] = "#{@vm.name} has been saved. You may resume at any time by pressing 'Start'."
  else
    flash[:error] = "Unsupported Virtual Machine Operation #{params[:action]}"
  end

  redirect "/vm/#{params[:uuid]}"
end
