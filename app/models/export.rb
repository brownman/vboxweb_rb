class Export < ActiveRecord::Base

  validates_presence_of :machine_uuid, :export_data

  serialize :export_data

  before_create :set_status_and_percent_exported_if_blank

  STATUSES = {
    :starting => 'Starting...',
    :failed => 'Failed... (is the vm running?)',
    :exporting => 'Exporting...',
    :packaging => 'Packaging...',
    :completed => "Completed"
  }

  Export::STATUSES.keys.each do |status_value|
    define_method "#{status_value}?" do
      status.to_s.downcase == status_value.to_s
    end
  end

  def machine
    @machine ||= VirtualBox::VM.find(machine_uuid)
  end

  def filename
    @filename ||= export_data[:filename].to_s.parameterize
  end

  def filepath
    @filepath ||= Rails.root.join('exports', filename, filename+".ovf").to_s
  end

  def valid_export_data_keys
    %w{ description product product_url vendor vendor_url version license }
  end

  def export_options
    options = Hash.new
    export_data.each do |key, value|
      next unless valid_export_data_keys.include?(key.to_s) && value.present?
      options[key.to_sym] = value
    end
    options
  end

  def export!
    unless machine.powered_off?
      update_attribute(:status, 'failed')
      return false
    end
    update_attribute(:status, 'exporting')
    machine.export(filepath, export_options) do |progress|
      update_attribute(:percent_exported, progress.percent)
    end
    update_attribute(:status, 'packaging')
    package
    update_attribute(:status, 'completed')
  rescue
    update_attribute(:status, 'failed')
  end
  handle_asynchronously :export!

  def packaged_dir_path
    Rails.root.join('exports', filename).to_s
  end

  def packaged_file_path
    Rails.root.join('exports', filename, filename+".tar").to_s
  end

  def package
    unless File.exist?(packaged_file_path)
      require 'zlib'
      require 'archive/tar/minitar'
      exported_files = Dir.glob(File.join(packaged_dir_path, "**", "*"))
      File.open(packaged_file_path, 'wb') do |tar|
        ::Archive::Tar::Minitar::Output.open(tar) do |output|
          Dir.chdir(packaged_dir_path) do
            exported_files.each { |f| ::Archive::Tar::Minitar.pack_file(f, output) }
          end
        end
      end
    end
    packaged_file_path
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
    elsif File.directory?(packaged_dir_path)
      errors.add_to_base("Export of this name already exists. Please choose another.")
      false
    else
      true
    end
  end

end
