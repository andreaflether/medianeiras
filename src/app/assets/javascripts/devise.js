// require rails-ujs
// require admin-lte/bower_components/jquery/dist/jquery.min
// require admin-lte/bower_components/bootstrap/dist/js/bootstrap.min
// require admin-lte/dist/js/adminlte.min
// require admin-lte/plugins/iCheck/icheck.min
// require toastr/build/toastr.min

$(document).ready(function() {
  $('input').iCheck({
    checkboxClass : 'icheckbox_square-blue',
    cursor        : true,
    increaseArea  : '20%' /* optional */,
    labelHover    : true,
    radioClass    : 'iradio_square-blue',
  });

  toastr.options = {
    extendedTimeOut   : 3000,
    preventDuplicates : true,
    progressBar       : true,
    timeOut           : 7000,
  }
})
