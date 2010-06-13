class Import < ActiveRecord::Base

  validates_presence_of :filepath

  before_create :set_status_and_percent_imported_if_blank

  STATUSES = {
    :starting => 'Starting...',
    :failed => 'Failed...',
    :importing => 'Importing...',
    :completed => "Completed"
  }

  Import::STATUSES.keys.each do |status_value|
    define_method "#{status_value}?" do
      status.to_s.downcase == status_value.to_s
    end
  end

  def upload(archive_file)
    filename = archive_file.original_filename.gsub(/[^\w\d\-\.]/i, '_').gsub(/(^_*|_*$)/i, '').split('.')[0..-2].join('.')

    if filename.blank?
      errors[:base] << "You must upload an OVF file with a valid filename containing only letters, numbers, underscores, dashes, and periods."
      FileUtils.rm_rf(archive_file.path) rescue nil
      return false
    end

    dest_path = Rails.root.join("imports/#{filename}")

    if File.directory?(dest_path.to_s)
     errors[:base] << "Looks like an import of this name already exists. Please rename the archive file and try again."
     FileUtils.rm_rf(archive_file.path) rescue nil
     return false
    end

    FileUtils.mkdir_p(dest_path.to_s)

    Dir.chdir(dest_path.to_s) do
      require 'zlib'
      require 'archive/tar/minitar'
      Archive::Tar::Minitar.unpack(archive_file.path, dest_path.to_s)
      ovf_file = Dir['*.ovf'].first

      if ovf_file.blank?
        errors[:base] << "No OVF file was found within the uploaded archive #{archive_file.original_filename}."
        FileUtils.rm_rf(dest_path.to_s) rescue nil
        FileUtils.rm_rf(archive_file.path) rescue nil
        return false
      end

      return false unless valid_ovf_file?(dest_path.join(ovf_file).to_s)
    end

    true # upload successful
  end

  def import!
    update_attribute(:status, 'importing')
    vm = VirtualBox::VM.import(filepath) do |progress|
      update_attribute(:percent_imported, progress.percent)
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

  def valid_ovf_file?(filepath)
    begin
      # Check that the file is readable (makes sure that they supplied a correct OVF filepath)
      VirtualBox::Appliance.new(filepath)
      true
    rescue VirtualBox::Exceptions::FileErrorException, VirtualBox::Exceptions::FFIException
      errors[:base] << "The filepath or import archive supplied cannot be successfully read. Was it an OVF file?"
      false
    end
  end

  def validate
    if !filepath || !File.exist?(filepath)
      errors[:base] << "You must specify a valid filepath."
      false
    else
      valid_ovf_file?(filepath)
    end
  end

end
