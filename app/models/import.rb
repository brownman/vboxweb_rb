class Import < ActiveRecord::Base

  validates_presence_of :filepath

  before_create :set_status_and_percent_imported_if_blank

  STATUSES = {
    :starting => 'Starting...',
    :failed => 'Failed... (is the vm running?)',
    :importing => 'Importing...',
    :completed => "Completed"
  }

  Import::STATUSES.keys.each do |status_value|
    define_method "#{status_value}?" do
      status.to_s.downcase == status_value.to_s
    end
  end

  def import!
    update_attribute(:status, 'importing')
    vm = VirtualBox::VM.import(filepath) do |percent|
      update_attribute(:percent_imported, percent)
    end
    update_attribute(:machine_uuid, vm.uuid)
    update_attribute(:status, 'completed')
  rescue
    update_attribute(:status, 'failed')
  end
  handle_asynchronously :import!

  def machine
    return unless completed?
    @machine ||= VirtualBox::VM.find(machine_uuid)
  end

  private

  def set_status_and_percent_imported_if_blank
    self.status = 'starting' if self.status.blank?
    self.percent_imported = 0 if self.percent_imported.blank?
  end

  def validate
    if !filepath || !File.exist?(filepath)
      errors.add_to_base("You must specify a valid filepath.")
      false
    else
      begin
        # Check that the file is readable (makes sure that they supplied a correct OVF filepath)
        VirtualBox::Appliance.new(filepath)
        true
      rescue VirtualBox::Exceptions::FileErrorException
        errors.add_to_base("The filepath supplied cannot be successfully read. Was it an OVF file?")
        false
      end
    end
  end

end
