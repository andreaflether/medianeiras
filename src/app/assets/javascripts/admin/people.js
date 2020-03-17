$(document).ready(function() {
  // Datemask dd/mm/yyyy
  $('#birthday').inputmask('dd/mm/yyyy', { 'placeholder': 'dd/mm/aaaa' })

  // Dependent fields
  DependentFields.bind();

  // Status - When disabled, it activates the Exit Date
  $('#status').change(function(){
    if ($('#status').is(':checked') == true){
      $('#exit_date').val('').prop('disabled', true);      
    } else {
      $('#exit_date').val('').prop('disabled', false);
    }
  });
});
