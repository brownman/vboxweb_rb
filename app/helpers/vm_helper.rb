module VmHelper

  def audio_drivers
    [ ['None', 'none'],
      ['Null Audio Driver', 'null'],
      ['CoreAudio', 'coreaudio'] ]
  end

  def audio_controllers
    [ ['ICH AC97', 'ac97'],
      ['SoundBlaster 16', 'sb16'] ]
  end

  def vm_data_headings
    %w{ controls general system display storage audio
        network serial_ports usb shared_folders }
  end

  def formatted_boot_order_from_vm(vm)
    [vm.boot1, vm.boot2, vm.boot3, vm.boot4].collect do |boot_item|
      case boot_item.downcase
      when 'floppy'           then "Floppy"
      when 'dvd'              then "CD/DVD-ROM"
      when 'disk', 'harddisk' then "Hard Disk"
      when 'net', 'network'   then "Network"
      when 'none'             then nil
      else                         boot_item
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

  def formatted_audio_driver_from_vm(vm)
    driver = audio_drivers.find { |name, code| code == vm.audiodriver.downcase }
    driver ? driver.first : vm.audiodriver
  end

  def formatted_audio_controller_from_vm(vm)
    controller = audio_controllers.find { |name, code| code == vm.audiocontroller.downcase }
    controller ? controller.first : vm.audiocontroller
  end

end
