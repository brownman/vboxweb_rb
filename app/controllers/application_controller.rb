class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  helper VmAttributesHelper

  before_filter :password_protect

  private

  def password_protect
    authenticate_or_request_with_http_basic do |username, password|
      [username, password] == [APP_CONFIG['username'], APP_CONFIG['password']]
    end
  end

  def find_virtual_machine_from_uuid
    @vm = VirtualBox::VM.find(params[:uuid])
    unless @vm
      flash[:error] = "This Virtual Machine does not exist!"
      redirect_to root_path
    end
  end

  def redirect_unless_vm_powered_off
    unless @vm.powered_off?
      flash[:error] = "You cannot access this operation unless the Virtual Machine is powered off."
      redirect_to vm_path
    end
  end

  def find_hard_drive_from_uuid
    @hd = VirtualBox::HardDrive.find(params[:uuid])
    unless @hd
      flash[:error] = "This Hard Drive does not exist!"
      redirect_to root_path
    end
  end
end
