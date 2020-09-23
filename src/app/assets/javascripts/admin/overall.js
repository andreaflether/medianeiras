$(document).ready(function() {
  // Activate tooltip on the whole application
  $('[data-toggle="tooltip"]').tooltip({
    trigger : 'hover',
    'data-container': 'body',
  });

  // Initialize Select2 elements
  $('select.select2').select2({
    width             : 'auto',
    dropdownAutoWidth : true
  });

  // Datepicker
  $('.datepicker').daterangepicker({
    singleDatePicker: true,
    showDropdowns: true,
    locale: {
			format      : 'DD/MM/YYYY',
			applyLabel  : 'Salvar',
      cancelLabel : 'Cancelar'
    },
    autoApply : true,
  })

 // Timepicker
  $('.timepicker').timepicker({
    defaultTime  : false,
    minuteStep   : 10,
    showInputs   : false,
    showMeridian : false,
  })

  // Toastr config
  toastr.options = {
    closeButton     : true,
    extendedTimeOut : 3000,    // How long the toast will display after a user hovers over it
    progressBar     : true,    // Visually indicate how long before a toast expires.
    timeOut         : 6000,    // How long the toast will display without user interaction
  }
  
  dataConfirmModal.setDefaults({
    commit: 'Confirmar',
    cancel: 'Cancelar'
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
    dom: "<'row'<'col-sm-6 col-xs-12'B><'col-sm-6 col-xs-12'f>>" +
          "<'row'<'col-md-6'><'col-md-6'>>" +
          "<'row'<'col-md-12't>><'row'<'col-md-4 col-xs-12 col-sm-6'l><'col-md-4 col-xs-12 col-sm-6'p><'col-xs-12 col-md-4 col-sm-12'i>>",
    buttons: [
      { extend: 'pdf', text: 'PDF', 
      customize: function (doc) {
        // 100% width
        doc.content[1].table.widths = 
            Array(doc.content[1].table.body[0].length + 1).join('*').split('');
      }, className: 'btn btn-default', ...customizeColumns },
      { extend: 'excel', text: 'Planilha Excel', className: 'btn btn-default', ...customizeColumns },
      { extend: 'print', text: 'Imprimir', className: 'btn btn-default', ...customizeColumns }, 
    ],
    autoWidth     : false,
    info          : true,
    lengthChange  : true,
    paging        : true,
    searching     : true,
    ordering      : true,
    language: {
      url: 'https://cdn.datatables.net/plug-ins/1.10.20/i18n/Portuguese-Brasil.json'
    },
  });

  // Add active class to sidebar
  $("ul.sidebar-menu li a[href='"+document.location.pathname+"']").parents('li').addClass('active');
})