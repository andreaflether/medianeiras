$(document).ready(function() {
  // Datemask dd/mm/yyyy
  $('#person_birthday').inputmask(
    'dd/mm/yyyy', { 'placeholder': 'dd/mm/yyyy' }
    )
  // $('#activity_max_capacity').inputmask('Regex', { regex: "^[1-9][0-9]?$|^100$" });
  // Dependent fields
  // DependentFields.bind();

  // Status - Activates the 'Exit Date' field when disabled
  // $('#status').change(function(){
  //   if ($('#status').is(':checked') == true){
  //     $('#exit_date').val('').prop('disabled', true);
  //   } else {
  //     $('#exit_date').val('').prop('disabled', false);
  //   }
  // });

  let cep_input = $('#user_zip_code');
  var search_zip = $('#search_zip');

  cep_input.on('change', function() {
    search_zip.attr('href', '/zip_code/?zip_code=' + cep_input.val());
  })
});
