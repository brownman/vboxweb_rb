
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
