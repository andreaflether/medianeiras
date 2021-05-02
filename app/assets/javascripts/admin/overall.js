$(document).ready(function() {
  // Activate tooltip on the whole application
  $('[data-toggle="tooltip"]').tooltip({
    trigger: 'hover',
  });

  // Initialize Select2 elements
  $('select.select2').select2({
    language: 'pt-BR'
  });

  // Data confirm modal default config
  dataConfirmModal.setDefaults({
    commit: 'Confirmar',
    cancel: 'Cancelar'
  });

  // Initialize DependentFields
  DependentFields.bind();

 // Timepicker
  $('.timepicker').datetimepicker({
    format: 'LT',
    stepping: 10,
    buttons: {
      showClose: true,
      showClear: true
    },
    tooltips: {
      clear: 'Limpar horário selecionado',
      close: 'Fechar seletor',
      incrementHour: 'Aumentar hora',
      pickHour: 'Escolher hora',
      decrementHour:'Diminuir hora',
      incrementMinute: 'Aumentar minutos',
      pickMinute: 'Escolher minutos',
      decrementMinute:'Diminuir minutos',
      incrementSecond: 'Aumentar segundos',
      pickSecond: 'Escolher segundos',
      decrementSecond:'Diminuir segundos'
    }
  });

  // Hide datetimepicker by clicking outside the widget
  $(document).on('mouseup touchend', function (e) {
    var container = $('.bootstrap-datetimepicker-widget');
    if (!container.is(e.target) && container.has(e.target).length === 0) {
      container.hide();
    }
  });
  
  // Don't show a certain column when table is exported to a specific format
  const customizeColumns = { 
    exportOptions: {
      columns: function (idx, data, node) {
        if (node.innerHTML == "Ações" || node.hidden)
          return false;
        return true;
      }
    }
  }

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
  
  $('.datepicker').daterangepicker({
    ...dateRangePickerOptions,
    autoUpdateInput: false
  });

  $('.datepicker').on('apply.daterangepicker', function(ev, picker) {
    $(this).val(picker.startDate.format('DD [de] MMMM [de] YYYY'));
  });

  // DataTables
  $('.dataTable').DataTable({
    dom: "<'row align-items-center px-3'<'col-sm-6 col-xs-12 mt-3 mb-2'B><'col-sm-6 col-xs-12 mt-3'f>>" +
          "<'row'<'col-md-6'><'col-md-6'>>" +
          "<'row'<'col-md-12't>><'row px-3'<'col-md-6 py-2'i><'col-md-6 py-2'p>>",
    buttons: {
      buttons: [
      { 
        extend: 'pdf', 
        text: '<i class="far fa-file-pdf mr-1"></i> PDF', 
        customize: function (doc) {
          // 100% width
          doc.content[1].table.widths = 
              Array(doc.content[1].table.body[0].length + 1).join('*').split('');
        }, 
        ...customizeColumns 
      },
      { 
        extend: 'excel', 
        text: '<i class="far fa-file-excel mr-1"></i> Planilha Excel', 
        ...customizeColumns 
      },
      { 
        extend: 'print',
        text: '<i class="fas fa-print mr-1"></i> Imprimir', 
        ...customizeColumns 
      }, 
    ],
    dom: {
      button: {
        className: 'btn btn-default'
      }
    }
    },
    autoWidth: false,
    info: true,
    lengthChange: false,
    paging: true,
    searching: true,
    ordering: true,
    responsive: true,
    language: {
      url: 'https://cdn.datatables.net/plug-ins/1.10.20/i18n/Portuguese-Brasil.json'
    },
  });
  
  $('.custom-file-input').change(function(e) {
    var fileName = e.currentTarget.files[0].name;
    var customFileLabel = e.target.nextElementSibling;
    customFileLabel.innerText = fileName;
    /* Pure jquery
      //get the file name
      var fileName = $(this).val();
      //replace the "Choose a file" label
      $(this).next('.custom-file-label').html(fileName);
    */
  });

  let imageCache = $('#activity_display_image_cache').data('filename');

  if(imageCache.length) {
    $('.custom-file-label').text(imageCache);
  }
})