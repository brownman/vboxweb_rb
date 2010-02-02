module VmHelper

  def vm_data_headings
    %w{ controls general system display storage audio
        network serial_ports usb shared_folders }
  end

  def formatted_boot_order_from_vm(vm)
    [vm.boot1, vm.boot2, vm.boot3, vm.boot4].collect do |boot_item|
      case boot_item
      when 'floppy' then "Floppy"
      when 'dvd'    then "CD/DVD-ROM"
      when 'disk'   then "Hard Disk"
      when 'none'   then nil
      else               boot_item
      end
    end.compact.join(', ')
  end

  def formatted_vrd_state_from_vm(vm)
    case vm.vrdp
    when 'on'  then "Enabled (port #{vm.vrdpports})"
    when 'off' then "Disabled"
    else            vm.vrdp
    end
  end

  def formatted_audio_from_vm(vm)
    case vm.audio
    when 'coreaudio' then "CoreAudio"
    else                  vm.audio
    end
  end

end
