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
        os_types_of_family = operating_system_types.collect { |os_type| [os_type.description, os_type.id] }
        os_types_array << [family, os_types_of_family]
      end

      os_types_array
    end
  end

  def options_for(option_type, current_value = nil)
    values = case option_type
    when :audio_controllers
      %w{ ac97 sb16 }
    when :audio_drivers
      %w{ none null alsa core_audio direct_sound mmpm oss pulse sol_audio winmm }
    when :boot_types
      %w{ null floppy dvd hard_disk network }
    when :network_adapter_types
      %w{ null Am79C970A Am79C973 I82540EM I82543GC I82545EM Virtio }
    when :network_attachment_types
      %w{ null nat bridged internal host_only }
    end
    values = values.collect { |key| [t("vm.#{option_type}.#{key}"), key] }
    values = [[" - choose a #{option_type.to_s.humanize.singularize.downcase} - ", '']] + values
    options_for_select(values, current_value)
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
      boot_order << t("vm.boot_types.#{boot_item}")
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

  def any_hard_drives_attached_to?(vm)
    vm.medium_attachments.any? { |ma| ma.type == :hard_disk }
  end

  def missing_hard_drive_attachment_warning
    content_tag(:div, "This Virtual Machine has no Hard Drives attached to it.
      Therefore, some functionality has been disabled.", :class => 'flash error')
  end

end
