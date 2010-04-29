var progress_updater;

function update_progress_bar(element_id, url) {
  progress_updater = new Ajax.PeriodicalUpdater(element_id, url, { evalScripts: true });
}

function stop_progress_bar() {
  if(progress_updater) { progress_updater.stop(); }
}

document.observe('dom:loaded', function() {

  $$('.record, .action').each(function(record) {
    record.observe('click', function() {
      window.location = record.down('a').href;
    });
  });

  $$('a[data-view]').each(function(view_link) {
    var view_type = view_link.readAttribute('data-view');

    var current_open_view = window.location.hash || 'general'
    var re = new RegExp('^#?' + view_type + '$');
    if (current_open_view.match(re)) {
      view_link.up('li').addClassName('current_view');
    } else {
      $(view_type).hide();
    }
    $$('.data_box .heading').each(function(data_box_heading) { data_box_heading.hide(); });

    view_link.observe('click', function(event) {
      $$('.data_box').each(function(data_box) { data_box.hide(); });
      $$('.current_view').each(function(view_link_container) {
        view_link_container.removeClassName('current_view')
      });
      view_link.up('li').addClassName('current_view');
      $(view_type).show();
      window.location.hash = view_type;
      event.stop();
    });
  });

});
