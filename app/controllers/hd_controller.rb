class HdController < ApplicationController
  def show
    @hd = VirtualBox::HardDrive.find(params[:uuid])

    if @hd
      @vms_on_this_hd = VirtualBox::VM.all.select do |vm|
        vm.storage_controllers.any? { |sc| sc.devices.any? { |d| d.uuid == @hd.uuid } }
      end
    else
      flash[:error] = "This Hard Drive does not exist!"
      redirect_to root_path
    end
  end
end
