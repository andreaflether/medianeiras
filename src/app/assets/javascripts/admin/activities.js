$(document).on('turbolinks:load', function() {
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
})
