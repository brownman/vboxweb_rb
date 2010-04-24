class ImportController < ApplicationController
  before_filter :find_import_from_id, :except => [:index, :new]

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

  def progress
    render :layout => false
  end

  private

  def find_import_from_id
    @import = Import.find(params[:id])
  end
end
