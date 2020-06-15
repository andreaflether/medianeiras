require 'rails_helper'

RSpec.feature "Manter Eventos", type: :feature, js: true do
  before(:each) do 
    admin = create(:user, :admin)
    login_as(admin)
  end 

  describe 'CRUD' do 
    context 'criação' do 
      before(:each) do 
        visit(new_event_path)
      end 

      scenario 'cadastra um evento válido ao preencher todos os campos' do 
        fill_in('Nome', with: Faker::Lorem.sentence)
        fill_in('Descrição', with: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4))
        fill_in('start_date', with: DateTime.now)
        fill_in('end_date', with: Faker::Time.between(from: DateTime.now + 1, to: DateTime.now + 6))
        fill_in('Local', with: Faker::Lorem.sentence(word_count: rand(3..6)))
        
        click_button('Criar Evento')
    
        expect(page).to have_content(/Evento criado com sucesso/) 
        page.save_screenshot('evento_valido.png')
      end 
    
      scenario 'não cadastra um cliente ao deixar campos em branco' do 
        click_button('Criar Evento')

        expect(page).to have_content(/Há erros/)
        page.save_screenshot('evento_invalido.png')
      end
    end 
    
    context 'visualização' do 
      scenario 'mostra um evento' do 
        event = create(:event)
        visit(event_path(event.id))
        
        expect(page).to have_content(event.title)
      end 
    
      scenario 'lista todos os eventos cadastrados' do 
        events = create_list(:event, 5)
        visit events_path 
    
        expect(page).to have_content("#{Event.all.count} registros")
      end 
    end

    scenario 'atualização' do 
      event = create(:event)
      visit events_path

      first('.btn-primary').click
      fill_in('Nome', with: Faker::Lorem.sentence)
      click_button('Atualizar Evento')

      expect(page).to have_content(/atualizado com sucesso/)
      page.save_screenshot('evento_atualizado.png')
    end
    
    scenario 'exclusão' do 
      event = create(:event)
      visit(events_path)
      first('.btn-danger').click  
      page.driver.browser.switch_to.alert.accept

      expect(page).to have_content (/excluído com sucesso/)
      page.save_screenshot('evento_excluido.png')
    end 
  end 
  
  scenario 'input possui classe has-error quando o evento é inválido' do 
    visit(new_event_path)
    click_button('Criar Evento')
    
    expect(page).to have_css('.has-error')
  end

  describe 'botões' do   
    context 'visualização do evento' do 
      before(:each) do 
        @event = create(:event)
        visit(event_path(@event.id))
      end 

      it 'edição' do 
        first('.btn-primary').click
        expect(page).to have_current_path(edit_event_path(@event.id))
      end 

      it 'cadastro' do 
        first('.btn-success').click
        expect(page).to have_current_path(new_event_path)
      end 

      it 'exclusão' do 
        first('.btn-danger').click 
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content (/excluído com sucesso/)
      end 
    end 
  end 
end
