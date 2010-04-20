class HdController < ApplicationController
  before_filter :find_hard_drive_from_uuid

  def show
  end

  def release
    if request.delete?
      vms_on_this_hd.each do |vm|
        vm.medium_attachments.each { |ma| ma.detach if ma.type == :hard_disk }
      end
      flash[:notice] = "#{@hd.filename} has been detached from all Virtual Machines."
      redirect_to hd_path
    end
  end

  def remove
    if vms_on_this_hd.size > 0
      flash[:error] = "#{@hd.filename} cannot be deleted because it has virtual machines attached to it. Release them first."
      redirect_to hd_path
    end

    if request.delete?
      @hd.destroy(true)
      flash[:notice] = "#{@hd.filename} has been deleted."
      redirect_to root_path
    end
  end

  private

  def vms_on_this_hd
    @vms_on_this_hd ||= @hd.interface.machine_ids.collect { |vm_uuid| VirtualBox::VM.find(vm_uuid) }
  end
  helper_method :vms_on_this_hd
end
