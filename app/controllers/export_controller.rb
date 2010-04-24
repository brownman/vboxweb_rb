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
      export = Export.new(:machine_uuid => @vm.uuid, :export_data => params[:export])
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

  def destroy
    if request.delete?
      require 'fileutils'
      FileUtils.rm_rf(@export.packaged_dir_path) if File.directory?(@export.packaged_dir_path)
      @export.destroy
      flash[:notice] = "The selected export has now been deleted."
      redirect_to vm_exports_path
    end
  end

  private

  def find_export_from_id
    @export = Export.find(params[:id])
  end
end
