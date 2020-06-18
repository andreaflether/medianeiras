$(document).ready(function() {
  // Activate tooltip on the whole application
  $('[data-toggle="tooltip"]').tooltip({
    trigger : 'hover',
    'data-container': "body",
  });

  // Initialize Select2 elements
  $('.select2').select2();

 // Timepicker
  $('.timepicker').timepicker({
    showInputs: false,
    showMeridian: false,
  })

  // Toastr config
  toastr.options = {
    closeButton: true,
    progressBar: true,        // Visually indicate how long before a toast expires.
    timeOut: 6000,            // How long the toast will display without user interaction
    extendedTimeOut: 3000,    // How long the toast will display after a user hovers over it
  }

  // DataTables
  $('.dataTable').DataTable({
      'paging'      : true,
      'lengthChange': true,
      'searching'   : true,
      'ordering'    : true,
      'info'        : true,
      'autoWidth'   : false,

    language: {
      "url": "https://cdn.datatables.net/plug-ins/1.10.20/i18n/Portuguese-Brasil.json"
    },
  });

  // Add active class to sidebar
  $("ul.sidebar-menu li a[href='"+document.location.pathname+"']").parents('li').addClass('active');
})