$(document).ready(function() {
  // Initialize multiselect for Students on Activity form pages
  $('.activity_multiselect').bootstrapDualListbox({
    filterPlaceHolder     : 'Pesquisar Aluno(a)',
    filterTextClear       : 'Mostrar todos(as)',
    infoText              : 'Mostrando todos os alunos ({0})',
    infoTextEmpty         : 'Lista vazia',
    infoTextEmpty         : 'Nenhum resultado',
    infoTextFiltered      : '<span class="label label-primary">Filtrando</span> {0} resultados (de {1})',
    moveAllLabel          : 'Mover todos os alunos',
    moveOnSelect          : false,
    moveSelectedLabel     : 'Mover selecionados(as)',
    removeAllLabel        : 'Remover todos(as)',
    removeSelectedLabel   : 'Remover aluno(a) selecionado(a)',
    selectorMinimalHeight : 300,
  });

  const output = document.getElementById('img-preview');
  // $('.custom-file-label').html('Nenhum arquivo selecionado');

  $('#preview').on('click', function() {
    $('#preview-modal').modal('show');
  })

  $('#remove_photo').on('click', function() {
    document.getElementById('customFile').value = "";
    output.src = '/assets/img_placeholder.jpg'
    $('#preview_actions').addClass('hidden').removeClass('show')
    $('.custom-file-label').html('Nenhum arquivo selecionado');
  })
  
  if (window.FileList && window.File && window.FileReader) {
    document.getElementById('customFile').addEventListener('change', event => {
      output.src = '';
      status.textContent = '';
      const file = event.target.files[0];
      
      $('#preview_actions').addClass('show').removeClass('hidden')
      const reader = new FileReader();
      reader.addEventListener('load', event => {
        output.src = event.target.result;
      });
      reader.readAsDataURL(file);

      $('.custom-file-label').html(file.name);
    }); 
  }
})
