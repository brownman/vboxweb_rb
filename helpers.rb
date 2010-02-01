module VBoxWeb
  module Helpers

    def vbicon(filename, title = '')
      "<img src='/images/virtualbox/#{filename}.png' alt='#{title}' title='#{title}' />"
    end

    def link_to(text, path)
      "<a href='#{path}'>#{text}</a>"
    end

    def number_with_delimiter(number)
      begin
        parts = number.to_s.split('.')
        parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
        parts.join('.')
      rescue
        number
      end
    end

    def convert_from_mb_to_gb(megabytes)
      sprintf("%.2f", (megabytes.to_f / 1024.to_f))
    end

    def formatted_state_from(state)
      case state
      when 'running'  then vbicon("states/running_16px", 'Running') + " Running"
      when 'poweroff' then vbicon("states/powered_off_16px", 'Powered Off') + " Powered Off"
      when 'paused'   then vbicon("states/paused_16px", 'Paused') + " Paused"
      when 'saved'    then vbicon("states/saved_16px", 'Saved') + " Saved"
      when 'aborted'  then vbicon("states/aborted_16px", 'Saved') + " Aborted"
      when 'on'       then "Enabled"
      when 'off'      then "Disabled"
      else                 state
      end
    end

    def convert_ostype_to_icon(ostype)
      vbicon("os/#{ostype.downcase}", ostype)
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

    def formatted_display_of_drive(drive)
      if !drive || drive.empty_drive?
        "Empty"
      else
        text = drive.filename
        text += " (#{drive.format}, #{convert_from_mb_to_gb(drive.size)} GB)" if drive.image_type == 'hdd'
        text
      end
    end

  end
end
