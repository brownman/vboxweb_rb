document.observe('dom:loaded', function() {

  $$('.record, .action').each(function(record) {
    record.observe('click', function() {
      window.location = record.down('a').href;
    });
  });

});
