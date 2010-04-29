module SnapshotsHelper
  def snapshot_tree_from(root_snapshot, current_snapshot)
    html = "<ul id='snapshots_tree'>"
    html += "<li class='#{"current_parent" if root_snapshot.uuid == current_snapshot.uuid}'>"
    html += link_to(root_snapshot.name, vm_snapshot_path(:id => root_snapshot.uuid))
    html += " (#{time_ago_in_words(root_snapshot.time_stamp, true)} ago)"
    html += children_snapshot_tree_from(root_snapshot, current_snapshot)
    html += "</li>"
    html += "</ul>"
    html
  end

  def children_snapshot_tree_from(parent_snapshot, current_snapshot)
    return String.new unless parent_snapshot.children.size > 0 || parent_snapshot.uuid == current_snapshot.uuid

    html = "<ul>"
    parent_snapshot.children.each do |child_snapshot|
      html += "<li class='#{"current_parent" if child_snapshot.uuid == current_snapshot.uuid}'>"
      html += link_to(child_snapshot.name, vm_snapshot_path(:id => child_snapshot.uuid))
      html += " (#{time_ago_in_words(child_snapshot.time_stamp, true)} ago)"
      html += children_snapshot_tree_from(child_snapshot, current_snapshot)
      html += "</li>"
    end
    html += "<li class='current_state'>Current State</li>" if parent_snapshot.uuid == current_snapshot.uuid
    html += "</ul>"
  end
end
