require 'rails_helper'

RSpec.feature 'Manter Eventos', type: :feature, js: true do
  before(:each) do 
    admin = create(:user, :admin)
    login_as(admin)
  end 
  
  describe 'ações do CRUD' do 
    context 'GET /admin/events/new' do 
      before(:each) do 
        visit(new_event_path)
      end 
      
      scenario 'cadastra um evento válido ao preencher todos os campos' do 
        fill_in('Nome', with: Faker::Lorem.sentence)
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
        
        page.save_screenshot('eventos/campos_preenchidos.png')
        click_button('Criar Evento')
    
        expect(page).to have_content(/Evento criado com sucesso/) 
        page.save_screenshot('eventos/evento_valido.png')
      end 
    
      scenario 'não cadastra um evento ao deixar campos em branco' do 
        click_button('Criar Evento')

        expect(page).to have_content(/Há erros/)
        page.save_screenshot('eventos/evento_invalido.png')
      end
    end 
    
    context 'GET /admin/events/{id}' do 
      scenario 'página de visualização de um evento específico' do 
        event = create(:event)
        visit(event_path(event.id))
        
        expect(page).to have_content(event.title)
      end   
    end
    
    context 'GET /admin/events' do 
      before(:each) do 
        events = create_list(:event, 5)
        visit events_path
      end

      scenario 'lista todos os eventos cadastrados' do 
        sleep 5
        page.save_screenshot('eventos/consultar_eventos.png')
        expect(page).to have_content("#{Event.all.count} registros")
      end

      scenario 'botão de cadastro (ícone) redireciona para a url/admin/events/new' do 
        first('.btn-hover').click
        expect(page).to have_current_path(new_event_path)
      end 
    end 

    context 'GET /admin/events - botões do DataTables' do
      before(:each) do 
        visit events_path 
      end
      
      feature 'PDF' do 
        before(:each) do   
          click_and_wait('PDF')
        end
        
        scenario 'download do PDF é feito com sucesso', :js do 
          # expect(downloads.length).to eq(1)
          expect(download).to match(/.*\.pdf/)
        end 
        
        scenario 'evento recém criado aparece no PDF gerado', :js do  
          expect(parse_file).to have_content(/(Título)|(Data)|(Horário)|(Local)/)
        end 
      end 
      
      feature 'planilha Excel' do 
        before(:each) do   
          click_and_wait('Planilha Excel')
        end

        scenario 'download da planilha é feito com sucesso', :js do 
          expect(download).to match(/.*\.xlsx/)
        end

        scenario 'evento recém criado aparece na planilha gerada', :js do    
          expect(parse_file).to have_content(/(Título)|(Data)|(Horário)|(Local)/)
        end 
      end 
    end

    context 'GET /admin/events - botões de ação' do 
      before(:each) do 
        @event = create(:event)
        visit events_path
      end 

      scenario 'visualização' do 
        first('.btn-success').click 
        expect(current_path).to eq event_path(@event)
      end
      
      feature 'edição' do 
        before(:each) do 
          first('.btn-primary').click
        end 

        scenario 'dados persistem' do 
          visit event_path(@event)
          expect(page).to have_content(@event.title)
        end 
        
        scenario 'com campos válidos' do 
          fill_in('Nome', with: Faker::Lorem.sentence)
          click_button('Atualizar Evento')
    
          expect(page).to have_content(/atualizado com sucesso/)
          page.save_screenshot('eventos/evento_atualizado.png')
        end
  
        scenario 'com campos deixados em branco' do 
          fill_in('Nome', with: '')
          click_button('Atualizar Evento')
          expect(page).to have_content(/Há erros/)
        end 
      end 
      
      scenario 'exclusão' do 
        first('.btn-danger').click  
        click_button('Confirmar')
  
        sleep 4
        expect(page).to have_content (/excluído com sucesso/)
        page.save_screenshot('eventos/evento_excluido.png')
      end 
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

      it 'botão de edição redireciona para a url /admin/events/{id}' do 
        first('.btn-primary').click
        expect(page).to have_current_path(edit_event_path(@event.id))
      end 

      it 'botão de cadastro redireciona para a url/admin/events/new' do 
        first('.btn-success').click
        expect(page).to have_current_path(new_event_path)
      end 

      it 'botão de exclusão deleta evento (DELETE /admin/events/{id})' do 
        first('.btn-danger').click 
        click_button('Confirmar')
        expect(page).to have_content (/excluído com sucesso/)
      end 
    end 
  end 

  describe 'GET /admin/calendar' do
    scenario 'widget está presente na tela' do 
      visit calendar_path
      expect(page.has_css?('.fc-view-container')).to eq true
    end 

    context 'registros no calendário' do 
      before(:each) do 
        @event = create(:event)
        visit calendar_path 
      end

      scenario 'evento aparece normalmente' do
        expect(page).to have_content (@event.title)
      end 
      
      scenario 'evento redireciona para sua respectiva página de visualização' do         
        page.save_screenshot('eventos/calendario.png')
        page.find_link(nil, href: /#{@event.id}.html/).click 
        expect(current_path).to eq("#{event_path(@event.id)}.html")
      end 
    end 
  end

  context 'links da sidebar' do 
    before(:each) do 
      visit admin_index_path
    end 

    scenario 'criar evento' do 
      click_link('Eventos')
      click_link('Novo Evento')
      expect(page).to have_current_path(new_event_path)
    end 
    
    scenario 'listar eventos' do 
      click_link('Eventos')
      click_link('Listar Eventos')
      expect(page).to have_current_path(events_path)
    end 

    scenario 'calendário' do 
      click_link('Calendário')
      expect(page).to have_content(/#{I18n.t('date.month_names')[Date.today.month]}/)
    end 
  end 
end
