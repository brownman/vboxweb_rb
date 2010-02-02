class VmController < ApplicationController
  def show
    @vm = VirtualBox::VM.find(params[:uuid])
  end

  def execute
    @vm = VirtualBox::VM.find(params[:uuid])

    case params[:command]
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

    redirect_to :action => 'show', :uuid => params[:uuid]
  end
end
