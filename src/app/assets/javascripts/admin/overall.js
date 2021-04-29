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
    // buttons: ["copy", "csv", "excel", "pdf", "print"],
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
})