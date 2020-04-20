$(document).ready(function() {
    //Initialize Select2 Elements
  $('#activity_week_day_ids').select2({
    theme: 'bootstrap4',
    placeholder: "Selecione um ou mais dias"
  });

  $('#activity_ends_at, #activity_starts_at').datetimepicker({
    format: 'LT',
    stepping: 15,
  });

  $("#activity_starts_at").on("change.datetimepicker", function (e) {
    $('#activity_ends_at').datetimepicker('minDate', e.date);
  });

  // $("#activity_ends_at").on("change.datetimepicker", function (e) {
  //   $('#activity_starts_at').datetimepicker('minDate', e.date);
  // });

  $(document).on('mouseup touchend', function (e) {
    var container = $('.bootstrap-datetimepicker-widget');
    if (!container.is(e.target) && container.has(e.target).length === 0) {
      container.parent().datetimepicker('hide');
    }
  });

});
