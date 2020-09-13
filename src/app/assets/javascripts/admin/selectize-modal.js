$(document).ready(function() {
  var selectizeCallback = null;
  
  const input = $('#location_address')
  const inputGroup = input.parent()

  $('.locations').on('hide.bs.modal', function(e) {
    if (selectizeCallback != null) {
      selectizeCallback();
      selectizeCallback = null;
    }
    inputGroup.find('.invalid-feedback').remove();
    input.removeClass('is-invalid')
    $('.location').trigger('reset');
    var selectors = [Rails.linkDisableSelector, Rails.formEnableSelector].join(', ');
    $(selectors).each(function() {
      Rails.enableElement(this);
    })
  });

  $('.location').on('submit', function(e) {
    e.preventDefault();
    $.ajax({
      method: 'POST',
      url: $(this).attr('action'),
      data: $(this).serialize(),
      success: function(response) {
        selectizeCallback({value: response.id, text: response.description});
        selectizeCallback = null;
        
        $('.locations').modal('toggle');
      },
      error: function (response) {
        inputGroup.find('.help-block').remove();
        inputGroup.addClass('has-error');
        if (!inputGroup.find('.help-block').length) {
          inputGroup.append(`<div class="help-block">${response.responseJSON.address[0]}</div>`)
          var selectors = [Rails.linkDisableSelector, Rails.formEnableSelector].join(', ');
          $(selectors).each(function() {
            Rails.enableElement(this);
          })
        }
      }
    });
  });
  $('#event_location_id').removeClass('form-control');
  $('#event_location_id, .selectize').selectize({
    placeholder: 'Selecione um local',
    render: {
      option_create: function(data, escape) {
        return '<div class="create">Adicionar <strong>' + escape(data.input) + '</strong>&hellip;</div>';
      }
    },
    create: function(input, callback) {
      selectizeCallback = callback;

      $('.locations').modal();
      $('#location_description').val(input);
    }
  });
});