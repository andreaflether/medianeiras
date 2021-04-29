$(document).ready(function() {
	moment.updateLocale('pt-br', {
		weekdays: 'Domingo_Segunda-feira_Terça-feira_Quarta-feira_Quinta-feira_Sexta-feira_Sábado'.split('_'),
		months: 'Janeiro_Fevereiro_Março_Abril_Maio_Junho_Julho_Agosto_Setembro_Outubro_Novembro_Dezembro'.split('_')
	});

	const dateRangePickerOptions = {
		singleDatePicker: true,
		locale: {
			format: 'dddd, DD [de] MMMM [de] YYYY',
			applyLabel: 'Salvar',
			cancelLabel: 'Cancelar',
			daysOfWeek: [
				'Dom',
				'Seg',
				'Ter',
				'Qua',
				'Qui',
				'Sex',
				'Sab'
			],
			monthNames: [
				'Janeiro',	
				'Fevereiro',
				'Março',
				'Abril',
				'Maio',
				'Junho',
				'Julho',
				'Agosto',
				'Setembro',
				'Outubro',
				'Novembro',
				'Dezembro'
			],
			firstDay: 1
		}
	}
	
	$('#scheduled_for').daterangepicker({
		...dateRangePickerOptions,
		autoUpdateInput: false,
		minDate: moment(),
	});

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

	$("input[name='event[location_selection_type]']").change(function(){
		if ($(this).is(':checked') && $(this).val() == 'existing_location') {
			toggleNewLocationFieldsProp(true);
		} 
	}).change();

	$("input[name='event[location_selection_type]']").change(function(){
		if ($(this).is(':checked') && $(this).val() == 'new_location') {
			toggleNewLocationFieldsProp(false);
		}
	});
});