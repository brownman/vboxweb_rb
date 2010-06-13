class ImportController < ApplicationController
  before_filter :find_import_from_id, :except => [:index, :new, :upload]

  def index
  end

  def show
  end

  def new
    if request.post?
      import = Import.new(:filepath => params[:import][:filepath])
      if import.save
        import.import!
        flash[:notice] = "The supplied import path is now importing. You can see the progress of that import below."
        redirect_to vm_import_path(:id => import.id)
      else
        flash[:error] = import.errors.full_messages.join(', ')
      end
    end
  end

  def upload
    if request.post?
      import = Import.new
      if import.upload(params[:import_archive_file])
        flash[:notice] = "The supplied import archive has been uploaded. You can now proceed to import the Virtual Machine it contains."
        redirect_to vm_imports_path
      else
        flash[:error] = import.errors.full_messages.join(', ')
      end
    end
  end

  def progress
    render :layout => false
  end

  def destroy
    if request.delete?
      @import.destroy
      flash[:notice] = "The selected import has now been deleted. The machine it imported still exists though, and needs to be deleted separately."
      redirect_to vm_imports_path
    end
  end

  private

  def find_import_from_id
    @import = Import.find(params[:id])
  end
end
