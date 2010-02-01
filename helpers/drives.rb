
def formatted_display_of_drive(drive)
  if !drive || drive.empty_drive?
    "Empty"
  else
    text = drive.filename
    text += " (#{drive.format}, #{convert_from_mb_to_gb(drive.size)} GB)" if drive.image_type == 'hdd'
    text
  end
end
