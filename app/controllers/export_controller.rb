class ExportController < ApplicationController
  before_filter :find_virtual_machine_from_uuid, :except => [:index]
  before_filter :redirect_unless_vm_powered_off, :only => [:new, :create]

  def index
    @vm = VirtualBox::VM.find(params[:uuid])
  end

  def show
    @export = Export.find(params[:id])
  end

  def new
    if request.post?
      export = Export.new(:machine_id => @vm.uuid, :export_data => params[:export])
      if export.save
        export.export!
        flash[:notice] = "#{@vm.name} is now exporting. You can see the progress of that import below."
        redirect_to vm_export_path(:id => export.id)
      else
        flash[:error] = export.errors.full_messages.join(', ')
      end
    end
  end

  def progress
    @export = Export.find(params[:id])
    render :layout => false
  end

  private

  def find_virtual_machine_from_uuid
    @vm = VirtualBox::VM.find(params[:uuid])
  end

  def redirect_unless_vm_powered_off
    unless @vm.powered_off?
      flash[:error] = "Cannot export a virtual machine unless it is powered off."
      redirect_to vm_path
    end
  end
end
