$(document).ready(function() {
	moment.locale('pt-br', {
		weekdaysMin : 'Dom_Seg_Ter_Qua_Qui_Sex_Sáb'.split('_'),
	});

	$('#start_date').daterangepicker({
		singleDatePicker: true,		
		autoUpdateInput: false,
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

	// Preenche inputs ao preencher data
	$('#start_date, #end_date').on('apply.daterangepicker', function(ev, picker) {
    $(this).val(picker.startDate.format('DD/MM/YYYY - HH:mm'));
  });

  $('#start_date, #end_date').on('cancel.daterangepicker', function(ev, picker) {
    $(this).val('');
	});
	
	$('#end_date').daterangepicker({
		singleDatePicker: true,
		timePicker: true,
		timePicker24Hour: true,
		timePickerIncrement: 15,
		autoUpdateInput: false,
		minDate : moment(),
		locale: {
			format: 'DD/MM/YYYY HH:mm',
			applyLabel: "Salvar",
			cancelLabel: "Cancelar"
		},
		startDate: moment().endOf('hour').add(1, 'm').add(1, 'h'),
	});
	
	// Troca valores mínimos da data final a partir das seleções em data de inínio
	$('#start_date').on('apply.daterangepicker', function(ev, picker) {
		var new_start = picker.startDate.clone().add(1, 'h');
    $('#end_date').daterangepicker({
      singleDatePicker: true,
			minDate: new_start,
			timePicker: true,
			timePicker24Hour: true,
			timePickerIncrement: 15,
			locale: {
				format: 'DD/MM/YYYY HH:mm',
				applyLabel: "Salvar",
				cancelLabel: "Cancelar"
			},
			startDate: new_start
		});
		$('#end_date').data('daterangepicker').startDate = new_start;
	});
});