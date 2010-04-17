var export_progress_updater;

function update_export_progress(element_id, url) {
  export_progress_updater = new Ajax.PeriodicalUpdater(element_id, url, { evalScripts: true });
}

function stop_current_export_progress() {
  if(export_progress_updater) { export_progress_updater.stop(); }
}

document.observe('dom:loaded', function() {

  $$('.record, .action').each(function(record) {
    record.observe('click', function() {
      window.location = record.down('a').href;
    });
  });

  $$('a[data-view]').each(function(view_link) {
    view_link.observe('click', function(event) {
      $$('.data_box').each(function(data_box) { data_box.hide(); });
      $$('.current_view').each(function(view_link_container) {
        view_link_container.removeClassName('current_view')
      });
      var view_type = view_link.readAttribute('data-view');
      view_link.up('li').addClassName('current_view');
      $(view_type).show();
      event.stop();
    });
  });

});
