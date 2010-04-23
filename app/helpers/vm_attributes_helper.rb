module VmAttributesHelper

  def name_description
    content_tag(:span, "Name of the virtual machine.<br /><br />
    Name must be unique and contain only alpha-numeric characters (a-z 0-9), underscores (_),
    and dashes (-).".html_safe)
  end

  def os_type_id_description
    content_tag(:span, "The Operating System to be run or being run on this Virtual
    Machine.".html_safe)
  end

  def snapshot_folder_description
    content_tag(:span, "Full path to the directory used to store snapshot data
    (differencing media and saved state files) of this machine.".html_safe)
  end

  def memory_size_description
    content_tag(:span, "System memory size in megabytes.".html_safe)
  end

  def memory_balloon_size_description
    content_tag(:span, "Initial memory balloon size in megabytes.".html_safe)
  end

  def cpu_count_description
    content_tag(:span, "Number of virtual CPUs in the VM.".html_safe)
  end

  def vram_size_description
    content_tag(:span, "Video memory size in megabytes.".html_safe)
  end

  def accelerate_3d_enabled_description
    content_tag(:span, "This setting determines whether VirtualBox allows this machine
    to make use of the 3D graphics support available on the host. ".html_safe)
  end

  def accelerate_2d_video_enabled_description
    content_tag(:span, "This setting determines whether VirtualBox allows this machine
    to make use of the 2D video acceleration support available on the host. ".html_safe)
  end

end
