module VmHelper

  # A list of specific OS types, grouped under their parent OS type
  # Contains the OS name, as well as the value virtualbox interprets
  def os_types
    @os_types ||= begin
      os_types_group = Hash.new
      VirtualBox::Global.global.lib.virtualbox.guest_os_types.each do |os_type|
        os_types_group[os_type.family_id] ||= Array.new
        os_types_group[os_type.family_id] << os_type
      end

      os_types_array = Array.new
      os_types_group.each do |family, operating_system_types|
        os_types_of_family = operating_system_types.collect { |os_type| [os_type.description, os_type.id.downcase] }
        os_types_array << [family, os_types_of_family]
      end

      os_types_array
    end
  end

  def boot_types
    [ ['None', 'null'],
      ['Floppy', 'floppy'],
      ['CD / DVD-ROM', 'dvd'],
      ['Hard Disk', 'hard_disk'],
      ['Network', 'network'] ]
  end

  def audio_drivers
    [ ['None', 'none'],
      ['Null Audio Driver', 'null'],
      ['CoreAudio', 'core_audio'] ]
  end

  def audio_controllers
    [ ['ICH AC97', 'ac97'],
      ['SoundBlaster 16', 'sb16'] ]
  end

  def network_attachment_types
    [ ['Not Attached', 'null'],
      ['NAT', 'nat'],
      ['Bridged Adapter', 'bridged'],
      ['Internal Network', 'internal'],
      ['Host-only Adapter', 'host_only'] ]
  end

  def network_adapter_types
    [ ['No Adapter', 'null'],
      ['PCnet-PCI II', 'Am79C970A'],
      ['PCnet-FAST III', 'Am79C973'],
      ['Intel PRO/1000 MT Desktop', 'I82540EM'],
      ['Intel PRO/1000 T Server', 'I82543GC'],
      ['Intel PRO/1000 MT Server', 'I82545EM'],
      ['Paravirtualized Network', 'Virtio'] ]
  end

  def get_system_property(property_name)
    @system_properties ||= VirtualBox::Global.global.system_properties
    @system_properties.send(property_name.to_sym)
  end

  def formatted_boot_order_from_vm(vm)
    boot_order = Array.new
    get_system_property(:max_boot_position).times do |i|
      boot_item = vm.interface.get_boot_order(i + 1).to_s
      next if boot_item == 'null'
      boot_type = boot_types.find { |name, code| code == boot_item }
      boot_order << (boot_type ? boot_type.first : boot_item)
    end
    boot_order.join(', ')
  end

  def formatted_access_from_shared_folder(shared_folder)
    if shared_folder.accessible && shared_folder.writable
      "Full Access"
    elsif shared_folder.accessible
      "Read-only"
    end
  end

  def vm_ostype_dropdown(field_name, vm=nil)
    select_tag(field_name, grouped_options_for_select(os_types, (vm.os_type_id.downcase if vm)).html_safe)
  end

  def any_hard_drives_attached_to?(vm)
    vm.medium_attachments.any? { |ma| ma.type == :hard_disk }
  end

  def missing_hard_drive_attachment_warning
    content_tag(:div, "This Virtual Machine has no Hard Drives attached to it.
      Therefore, some functionality has been disabled.", :class => 'flash error')
  end

end
