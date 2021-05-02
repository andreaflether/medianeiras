$(document).ready(function() {
	$('#scheduled_for, #end_date').on('apply.daterangepicker', function(ev, picker) {
    $(this).val(picker.startDate.format('dddd, DD [de] MMMM [de] YYYY'));
  });
	
	function toggleNewLocationFieldsProp(state) {
		$('#new-location-fields input').each(function() {
			$(this).prop('disabled', state);

			if(state) {
				$(this).val('');
			}
		});
	}

	$('input[name*="[location_selection_type]"]').change(function(){
		if ($(this).is(':checked') && $(this).val() == 'existing_location') {
			toggleNewLocationFieldsProp(true);
		} 
	}).change();

	$('input[name*="[location_selection_type]"]').change(function(){
		if ($(this).is(':checked') && $(this).val() == 'new_location') {
			toggleNewLocationFieldsProp(false);
		}
	});
});