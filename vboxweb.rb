#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra/base'
require 'erb'
require 'less'

require 'rack-flash'
require 'rack/utils'

require 'virtualbox'

require 'helpers'

module VBoxWeb
  class Application < Sinatra::Base

    # Because we use Sinatra::Base, we need to enable a few things
    set :sessions, true
    set :logging, true
    set :root, File.dirname(__FILE__)
    set :static, true
    set :public, Proc.new { File.join(root, "public") }
    set :views, Proc.new { File.join(root, "views") }

    def self.configuration
      @@configuration ||= YAML.load(IO.read(File.join(File.dirname(__FILE__), 'config.yml')))
    end

    use Rack::Auth::Basic do |username, password|
      [username, password] == [self.configuration['username'], self.configuration['password']]
    end

    use Rack::Flash # flash[] support

    configure do
      VirtualBox::Command.vboxmanage = self.configuration['vboxmanage']

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
      when 'discard'
        @vm.discard_state(true)
        flash[:notice] = "#{@vm.name} saved state has been discarded."
      else
        flash[:error] = "Unsupported Virtual Machine Operation '#{params[:action]}'"
      end

      redirect "/vm/#{params[:uuid]}"
    end

  end
end
