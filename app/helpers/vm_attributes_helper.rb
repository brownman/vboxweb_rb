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

  # Hmm, a BAD name! :-P Lets keep it!
  def description_description
    content_tag(:span, "Description of the virtual machine.<br /><br />
    The description attribute can contain any text and is typically used to describe
    the hardware and software configuration of the virtual machine in detail (i.e.
    network settings, versions of the installed software and so on).".html_safe)
  end

  def memory_size_description
    content_tag(:span, "System memory size in megabytes.".html_safe)
  end

  def memory_balloon_size_description
    content_tag(:span, "Initial memory balloon size in megabytes.".html_safe)
  end

  def acpi_enabled_description
    content_tag(:span, "ACPI support flag.".html_safe)
  end

  def io_apic_enabled_description
    content_tag(:span, "IO APIC support flag.<br /><br />
    If set, VirtualBox will provide an IO APIC and support IRQs above 15.".html_safe)
  end

  def cpu_count_description
    content_tag(:span, "Number of virtual CPUs in the VM.".html_safe)
  end

  def pae_description
    content_tag(:span, "This setting determines whether VirtualBox will expose the
    Physical Address Extension (PAE) feature of the host CPU to the guest.<br /><br />
    Note that in case PAE is not available, it will not be reported.".html_safe)
  end

  def synthetic_description
    content_tag(:span, "This setting determines whether VirtualBox will expose a
    synthetic CPU to the guest to allow teleporting between host systems that
    differ significantly. ".html_safe)
  end

  def vtx_description
    content_tag(:span, "Whether hardware virtualization (VT-x/AMD-V) is enabled.".html_safe)
  end

  def nested_paging_description
    content_tag(:span, "Whether Nested Paging is enabled.<br /><br />
    If this extension is not available, it will not be used.".html_safe)
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

  def audio_enabled_description
    content_tag(:span, "Whether the audio adapter is present in the guest system.<br /><br />
    If disabled, the virtual guest hardware will not contain any audio adapter.".html_safe)
  end

  def audio_driver_description
    content_tag(:span, "Audio driver the adapter is connected to.".html_safe)
  end

  def audio_controller_description
    content_tag(:span, "The audio hardware to emulate.".html_safe)
  end

end
