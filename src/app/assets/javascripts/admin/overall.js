$(document).ready(function() {
  // Activate tooltip on the whole application
  $('[data-toggle="tooltip"]').tooltip();
  
  // DataTables
  $('.dataTable').DataTable({
    dom: "<'row'<'col-md-4'l><'col-md-4'B><'col-md-4'f>>" +
          "<'row'<'col-md-6'><'col-md-6'>>" +
          "<'row'<'col-md-12't>><'row'<'col-md-6'i><'col-md-6'p>>",
    buttons: [
      { "extend": 'pdf', "text": 'PDF', "className": 'btn btn-default' /* Customization goes here */},
      { "extend": 'excel', "text": 'Planilha Excel', "className": 'btn btn-default' },
      { "extend": 'print', "text": 'Imprimir', "className": 'btn btn-default' },
      
    ],
    language: {
      "url": "https://cdn.datatables.net/plug-ins/1.10.20/i18n/Portuguese-Brasil.json"
    },
  });

  // Add active class to sidebar
  $('.nav-treeview > .nav-item > .nav-link').each(function () {
    var curr_page = ($(this)).attr('href');
    if (window.location.pathname == curr_page) {
      $(this).addClass("active");
      $(this).closest('.nav-treeview').prev().addClass('active');
      $(this).closest('.nav-treeview').css('display', "block");
      $(this).closest('.has-treeview').addClass('menu-open')
    }
  });

  // Toastr options
  toastr.options.timeOut = 6000; // How long the toast will display without user interaction
  toastr.options.progressBar = true; // Visually indicate how long before a toast expires.
  toastr.options.extendedTimeOut = 3000; // How long the toast will display after a user hovers over it
})