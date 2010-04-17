class Export < ActiveRecord::Base

  validates_presence_of :machine_id, :export_data

  serialize :export_data

  before_create :set_status_and_percent_exported_if_blank

  STATUSES = {
    :starting => 'Starting...',
    :failed => 'Failed... (if the vm running?)',
    :running => 'Running...',
    :finalizing => 'Finalizing...',
    :completed => "Completed"
  }

  def machine
    @machine ||= VirtualBox::VM.find(machine_id)
  end

  def filename
    @filename ||= export_data[:filename].to_s.parameterize
  end

  def filepath
    @filepath ||= Rails.root.join('exports', filename, filename+".ovf").to_s
  end

  def export!
    unless machine.powered_off?
      update_attribute(:status, 'failed')
      return false
    end
    update_attribute(:status, 'running')
    machine.export(filepath) do |percent|
      update_attribute(:percent_exported, percent)
      update_attribute(:status, 'finalizing') if percent.to_i == 100
    end
    update_attribute(:status, 'completed')
  end
  handle_asynchronously :export!

  Export::STATUSES.keys.each do |status_value|
    define_method "#{status_value}?" do
      status.to_s.downcase == status_value.to_s
    end
  end

  private

  def set_status_and_percent_exported_if_blank
    self.status = 'starting' if self.status.blank?
    self.percent_exported = 0 if self.percent_exported.blank?
  end

  def validate
    if filename.blank?
      errors.add_to_base("You must specify a filename to export to.")
      false
    elsif File.exist?(filepath)
      errors.add_to_base("Export of this name already exists. Please choose another.")
      false
    else
      true
    end
  end

end
