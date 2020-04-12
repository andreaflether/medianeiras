$(document).ready(function() {

	$('.breadcrumb > li').addClass('breadcrumb-item');

	$('#start_date').daterangepicker({
		singleDatePicker: true,		
		minDate : moment(),
		startDate: moment().endOf('hour').add(1, 'm'),
		timePicker: true,
		timePicker24Hour: true,
		timePickerIncrement: 15,
		locale: {
			format: 'DD/MM/YYYY HH:mm',
			applyLabel: "Salvar",
      cancelLabel: "Cancelar"
		}
	});

	$('#end_date').daterangepicker({
		singleDatePicker: true,
		timePicker: true,
		timePicker24Hour: true,
		timePickerIncrement: 30,
		locale: {
			format: 'DD/MM/YYYY HH:mm',
			applyLabel: "Salvar",
			cancelLabel: "Cancelar"
		},
		startDate: moment().endOf('hour').add(1, 'm').add(1, 'h'),
	});
	
	$('#start_date').on('apply.daterangepicker', function(ev, picker) {
		
		var new_start = picker.startDate.clone().add(1, 'h');

    $('#end_date').daterangepicker({
      singleDatePicker: true,
			minDate: new_start,
			timePicker: true,
			timePicker24Hour: true,
			timePickerIncrement: 30,
			locale: {
				format: 'DD/MM/YYYY HH:mm',
				applyLabel: "Salvar",
				cancelLabel: "Cancelar"
			},
			startDate: new_start
    });
	});
});