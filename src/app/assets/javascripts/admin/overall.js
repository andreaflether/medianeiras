$(document).ready(function() {
  // Activate tooltip on the whole application
  $('[data-toggle="tooltip"]').tooltip({
    trigger : 'hover',
    'data-container': "body",
  });

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
  // Toastr options
  toastr.options.timeOut = 6000; // How long the toast will display without user interaction
  toastr.options.progressBar = true; // Visually indicate how long before a toast expires.
  toastr.options.extendedTimeOut = 3000; // How long the toast will display after a user hovers over it
})