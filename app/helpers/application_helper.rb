module ApplicationHelper

  def vbicon(filename, title = '')
    image_tag("virtualbox/#{filename}.png", :alt => title, :title => title)
  end

  def convert_ostype_to_os_icon(ostype)
    vbicon("os/#{ostype.downcase}", ostype)
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
