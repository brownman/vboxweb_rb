class SnapshotsController < ApplicationController
  before_filter :find_virtual_machine_from_uuid
  before_filter :find_snapshot_from_id, :except => [:index, :new]

  def index
  end

  def show
    # Once we have the snapshot, lets overwrite it with the machine from
    # the snapshot (as each snapshot has its own machine and settings)
    @vm = @snapshot.machine
  end

  def new
    if request.post?
      if params[:snapshot] && params[:snapshot][:name].present?
        @vm.take_snapshot(params[:snapshot][:name], params[:snapshot][:description])
        redirect_to vm_snapshots_path
      else
        flash[:error] = "Please specify a snapshot name."
      end
    end
  end

  def restore
    if request.put?
      @snapshot.restore
      flash[:notice] = "The selected snapshot has been restored."
      redirect_to vm_snapshots_path
    end
  end

  def destroy
    if request.delete?
      @snapshot.destroy
      flash[:notice] = "The selected snapshot has been destroyed."
      redirect_to vm_snapshots_path
    end
  end

  private

  def find_snapshot_from_id
    @snapshot = @vm.find_snapshot(params[:id])
  end
end
