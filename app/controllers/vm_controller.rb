class VmController < ApplicationController
  def show
    @vm = VirtualBox::VM.find(params[:uuid])
  end

  def settings
    @vm = VirtualBox::VM.find(params[:uuid])

    unless @vm.powered_off?
      flash[:error] = "Cannot update a virtual machines settings unless it is powered off."
      redirect_to vm_path
    end

    if request.put?
      params[:settings].each do |attribute, value|
        @vm.send("#{attribute}=", value) if vm_attribute_changed?(attribute, value)
      end

      begin
        @vm.save(true)
        flash[:notice] = "#{@vm.name} settings have been updated."
      rescue VirtualBox::Exceptions::CommandFailedException => e
        if e.to_s =~ /A session for the machine [\w\']* is currently open/
          flash[:error] = "Cannot update settings because the virtual machine is either running, paused, or someone is already editing it."
        else
          flash[:error] = e.to_s
        end
      end

      redirect_to vm_path
    end
  end

  def export
    @vm = VirtualBox::VM.find(params[:uuid])
    if request.post?
      filename = params[:export].delete(:filename).parameterize.to_s
      filepath = Rails.root.join('exports', filename, filename + ".ovf")
      if File.exist?(filepath)
        flash[:error] = "Export of this name already exists. Please choose another."
      else
        @vm.export(filepath, params[:export], true)
        flash[:notice] = "#{@vm.name} has been exported to #{filepath}."
        redirect_to vm_path
      end
    end
  end

  def destroy
    @vm = VirtualBox::VM.find(params[:uuid])
    if request.delete?
      @vm.destroy
      flash[:notice] = "#{@vm.name} has been deleted."
      redirect_to root_path
    end
  end

  def control
    @vm = VirtualBox::VM.find(params[:uuid])

    case params[:command]
    when 'start'
      @vm.start(:headless)
      flash[:notice] = "#{@vm.name} has been started, but give it a minute to fully boot."
    when 'shutdown'
      @vm.shutdown
      flash[:notice] = "#{@vm.name} is being shutdown. Please wait a bit for it to complete and refresh the page."
    when 'poweroff'
      @vm.stop
      flash[:notice] = "#{@vm.name} has been powered off. Any unsaved data will have been lost."
    when 'pause'
      @vm.pause
      flash[:notice] = "#{@vm.name} has been paused."
    when 'resume'
      @vm.resume
      flash[:notice] = "#{@vm.name} has been resumed."
    when 'save'
      @vm.save_state
      flash[:notice] = "#{@vm.name} has been saved. You may resume at any time by pressing 'Start'."
    when 'discard'
      @vm.discard_state
      flash[:notice] = "#{@vm.name} saved state has been discarded."
    else
      flash[:error] = "Unsupported Virtual Machine Operation '#{params[:action]}'"
    end

    redirect_to vm_path
  end

  private

  # The difference between what we get in output, and what we send as input means
  # we need to do this conversion is several places :-(
  def vm_attribute_changed?(attribute, value)
    return false if @vm.send(attribute).downcase == 'harddisk' && value.downcase == 'disk'
    return false if @vm.send(attribute).downcase == 'true' && value.downcase == 'on'
    return false if @vm.send(attribute).downcase == 'false' && value.downcase == 'off'
    @vm.send(attribute).downcase != value.downcase
  end
end
