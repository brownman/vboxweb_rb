module HdHelper
  def formatted_display_of_drive(medium_attachment)
    if !medium_attachment || medium_attachment.medium.nil?
      "Empty"
    else
      medium = medium_attachment.medium
      text = medium.filename
      text += " (#{medium.format}, #{convert_from_mb_to_gb(medium.logical_size)} GB)" if medium_attachment.type == :hard_disk
      text
    end
  end
end
