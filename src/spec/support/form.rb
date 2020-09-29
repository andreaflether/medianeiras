module Form 
  def fill_all_fields 
    fill_in('Título', with: Faker::Lorem.sentence)
    fill_in('Descrição', with: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4))
    fill_in('start_date', with: DateTime.now.strftime("%d/%m/%Y %H:%M"))
    find('.applyBtn').click

    # Preenchendo o campo de 'Local' com o valor 'Teste'
    fill_in('event_location_id-selectized', with: 'Teste')
    find('.create').click
    
    # Modal para cadastro de Local
    fill_in('Endereço', with: Faker::Address.street_address)
    click_button('Salvar Local')
    sleep 8
  end
end 