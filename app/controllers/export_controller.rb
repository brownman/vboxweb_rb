class ExportController < ApplicationController
  before_filter :find_virtual_machine_from_uuid, :only => [:index, :new]
  before_filter :find_export_from_id, :except => [:index, :new]
  before_filter :redirect_unless_vm_powered_off, :only => [:new]

  def index
  end

  def show
  end

  def new
    if request.post?
      export = Export.new(:machine_id => @vm.uuid, :export_data => params[:export])
      if export.save
        export.export!
        flash[:notice] = "#{@vm.name} is now exporting. You can see the progress of that export below."
        redirect_to vm_export_path(:id => export.id)
      else
        flash[:error] = export.errors.full_messages.join(', ')
      end
    end
  end

  def progress
    render :layout => false
  end

  def download
    send_file(@export.package, :type => 'application/x-tar')
  end

  private

  def find_export_from_id
    @export = Export.find(params[:id])
  end
end
