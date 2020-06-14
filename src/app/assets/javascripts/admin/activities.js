$(document).ready(function() {

  // Initialize Select2 Elements
  $('#activity_week_day_ids').select2({
    theme: 'bootstrap4',
    dropdownAutoWidth : true,
    width: 'auto',
    placeholder: "Selecione um ou mais dias"
  });

  $('#activity_volunteer_ids').select2({
    theme: 'bootstrap4',
    dropdownAutoWidth : true,
    width: 'auto',
    placeholder: "Selecione um ou mais responsáveis pela atividade"
  })

  // Initialize multiselect for Students on New Activity page
  $('.activity_multiselect').lwMultiSelect({
    addAllText: "Selecionar todos",
    removeAllText: "Remover todos",
    selectedLabel: "Alunos selecionados"
  });
    
  // Initialize datetime picker for activity
  $('#activity_ends_at, #activity_starts_at').datetimepicker({
    format: 'LT',
    stepping: 15,
    // useCurrent: false
  });

  // Changes min time to be selected on ends_at based on starts_at
  $("#activity_starts_at").on("change.datetimepicker", function (e) {
    $('#activity_ends_at').datetimepicker('minDate', e.date);
  // });

  // Hide datetime picker when clicked outside the container
  $(document).on('mouseup touchend', function (e) {
    var container = $('.bootstrap-datetimepicker-widget');
    if (!container.is(e.target) && container.has(e.target).length === 0) {
      container.parent().datetimepicker('hide');
    }
  });
});
