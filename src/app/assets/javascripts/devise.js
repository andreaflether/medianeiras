//= require rails-ujs
//= require admin-lte/bower_components/jquery/dist/jquery.min
//= require admin-lte/bower_components/bootstrap/dist/js/bootstrap.min
//= require admin-lte/dist/js/adminlte.min
//= require admin-lte/plugins/iCheck/icheck.min
//= require toastr/build/toastr.min

$(document).ready(function() {
  $('input').iCheck({
    checkboxClass: 'icheckbox_square-blue',
    radioClass: 'iradio_square-blue',
    increaseArea: '20%' /* optional */,
    cursor: true,
    labelHover: true
  });

  toastr.options = {
    "progressBar": true,
    "preventDuplicates": true,
    "timeOut": "7000",
    "extendedTimeOut": "3000"
  }
})
