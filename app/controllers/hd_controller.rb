class HdController < ApplicationController
  def show
    @hd = VirtualBox::HardDrive.find(params[:uuid])

    if @hd
      @vms_on_this_hd = VirtualBox::VM.all.select do |vm|
        vm.storage_controllers.any? do |sc|
          sc.medium_attachments.any? { |ma| ma.type == :hard_disk && ma.medium.uuid == @hd.uuid }
        end
      end
    else
      flash[:error] = "This Hard Drive does not exist!"
      redirect_to root_path
    end
  end
end
