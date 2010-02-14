module VmHelper

  # A list of specific OS types, grouped under their parent OS type
  # Contains the OS name, as well as the value virtualbox interprets
  def os_types
    [ [
      'Microsoft Windows', [
        ['Windows 3.1', 'windows31'],
        ['Windows 95', 'windows95'],
        ['Windows 98', 'windows98'],
        ['Windows ME', 'windowsme'],
        ['Windows NT 4', 'windowsnt4'],
        ['Windows 2000', 'windows2000'],
        ['Windows XP', 'windowsxp'],
        ['Windows XP (64 bit)', 'windowsxp_64'],
        ['Windows 2003', 'windows2003'],
        ['Windows 2003 (64 bit)', 'windows2003_64'],
        ['Windows Vista', 'windowsvista'],
        ['Windows Vista (64 bit)', 'windowsvista_64'],
        ['Windows 2008', 'windows2008'],
        ['Windows 2008 (64 bit)', 'windows2008_64'],
        ['Windows 7', 'windows7'],
        ['Windows 7 (64 bit)', 'windows7_64'],
        ['Other Windows', 'windowsnt']
      ]
    ], [
        'Linux', [
        ['Linux 2.2', 'linux22'],
        ['Linux 2.4', 'linux24'],
        ['Linux 2.4 (64 bit)', 'linux24_64'],
        ['Linux 2.6', 'linux26'],
        ['Linux 2.6 (64 bit)', 'linux26_64'],
        ['Arch Linux', 'archlinux'],
        ['Arch Linux (64 bit)', 'archlinux_64'],
        ['Debian', 'debian'],
        ['Debian (64 bit)', 'debian_64'],
        ['openSUSE', 'opensuse'],
        ['openSUSE (64 bit)', 'opensuse_64'],
        ['Fedora', 'fedora'],
        ['Fedora (64 bit)', 'fedora_64'],
        ['Gentoo', 'gentoo'],
        ['Gentoo (64 bit)', 'gentoo_64'],
        ['Mandriva', 'mandriva'],
        ['Mandriva (64 bit)', 'mandriva_64'],
        ['Red Hat', 'redhat'],
        ['Red Hat (64 bit)', 'redhat_64'],
        ['Turbolinux', 'turbolinux'],
        ['Ubuntu', 'ubuntu'],
        ['Ubuntu (64 bit)', 'ubuntu_64'],
        ['Xandros', 'xandros'],
        ['Xandros (64 bit)', 'xandros_64'],
        ['Other Linux', 'linux']
      ]
    ], [
      'Solaris', [
        ['Solaris', 'solaris'],
        ['Solaris (64 bit)', 'solaris_64'],
        ['OpenSolaris', 'opensolaris'],
        ['OpenSolaris (64 bit)', 'opensolaris_64']
      ]
    ], [
      'BSD', [
        ['FreeBSD', 'freebsd'],
        ['FreeBSD (64 bit)', 'freebsd_64'],
        ['OpenBSD', 'openbsd'],
        ['OpenBSD (64 bit)', 'openbsd_64'],
        ['NetBSD', 'netbsd'],
        ['NetBSD (64 bit)', 'netbsd_64']
      ]
    ], [
      'IBM OS/2', [
        ['OS/2 Warp 3', 'os2warp3'],
        ['OS/2 Warp 4', 'os2warp4'],
        ['OS/2 Warp 4.5', 'os2warp45'],
        ['eComStation', 'os2ecs'],
        ['Other OS/2', 'os2']
      ]
    ], [
      'Other', [
        ['DOS', 'dos'],
        ['Netware', 'netware'],
        ['L4', 'l4'],
        ['QNX', 'qnx'],
        ['Other/Unknown', 'other'],
      ]
    ] ]
  end

  def boot_types
    [ ['None', 'none'],
      ['Floppy', 'floppy'],
      ['CD / DVD-ROM', 'dvd'],
      ['Hard Disk', 'disk'],
      ['Network', 'net'] ]
  end

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

  # Convert to a format recognised by 'vboxmanage modifyvm'
  def normalize_value(value)
    case value.downcase
    when 'harddisk' then 'disk'
    when 'network'  then 'net'
    else                 value.downcase
    end
  end

  def formatted_boot_order_from_vm(vm)
    [vm.boot1, vm.boot2, vm.boot3, vm.boot4].collect do |boot_item|
      boot_type = boot_types.find { |name, code| code == normalize_value(boot_item) }
      boot_type ? boot_type.first : boot_item
    end.reject { |b| b == 'None' }.join(', ')
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

  def vm_ostype_dropdown(field_name, vm=nil)
    select_tag(field_name, grouped_options_for_select(os_types, (vm.ostype.downcase if vm)))
  end

  def vm_boot_types_dropdown(field_name, current_boot_type='')
    select_tag(field_name, options_for_select(boot_types, normalize_value(current_boot_type)))
  end

  def vm_audio_driver_dropdown(field_name, vm=nil)
    select_tag(field_name, options_for_select(audio_drivers, (vm.audiodriver.downcase if vm && vm.audio == 'true')))
  end

  def vm_audio_controller_dropdown(field_name, vm=nil)
    select_tag(field_name, options_for_select(audio_controllers, (vm.audiocontroller.downcase if vm && vm.audio == 'true')))
  end

end
