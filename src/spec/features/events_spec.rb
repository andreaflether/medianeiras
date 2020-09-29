require 'rails_helper'

RSpec.feature 'Events', type: :feature, js: true do
  given(:admin) { create(:user, :admin) }
  given!(:event_list) { create_list(:event, 10) }

  before(:each) do 
    login_as(admin)
    visit events_path
    sleep 5
  end

  RSpec.shared_examples 'Edit' do |button_name|
    before(:each) do 
      sleep 5
      first(button_name).click
    end 
    
    scenario 'by updating Event with valid input' do 
      fill_in('Título', with: Faker::Lorem.sentence)
      click_button('Atualizar Evento')

      expect(page).to have_content(/atualizado com sucesso/)
      page.save_screenshot('eventos/evento_atualizado.png')
    end

    scenario 'by leaving Title blank' do 
      fill_in('Título', with: '')
      click_button('Atualizar Evento')
      expect(page).to have_content(/Há erros/)
    end       
  end

  RSpec.shared_examples 'Create' do |button_name|
    before(:each) do
      first(button_name).click
    end
    
    scenario 'when Admin provides valid input' do
      fill_all_fields
      click_button('Criar Evento')
    
      expect(page).to have_content(/Evento criado com sucesso/) 
    end 

    scenario 'when Admin provides invalid input' do
      click_button('Criar Evento')

      expect(page).to have_content(/Há erros/)
    end
  end

  RSpec.shared_examples 'Delete' do 
    scenario 'on button click' do 
      first('.btn-danger').click  
      click_button('Confirmar')
      sleep 4

      expect(page).to have_content (/excluído com sucesso/)
      page.save_screenshot('eventos/evento_excluido.png')
    end 
  end 

  feature 'new Event from GET /admin/events page' do 
    it_behaves_like 'Create', '.btn-hover'
  end 

  feature 'Action Buttons' do     
    feature 'SHOW' do 
      before(:each) do 
        first('.btn-success').click
      end

      feature 'Event creation through the SHOW page' do 
        it_behaves_like 'Create', '.btn-success'
      end 

      feature 'Event deletion through the SHOW page' do 
        it_behaves_like 'Delete'
      end

      feature 'Event update through the SHOW page' do 
        it_behaves_like 'Edit', '.btn-edit'
      end
    end

    feature 'when Admin updates Event' do 
      it_behaves_like 'Edit', '.btn-edit'
    end 

    feature 'when Admin deletes Event' do 
      it_behaves_like 'Delete'
    end 
  end 

  feature 'DataTables' do 
    scenario 'table shows all Events in the database' do 
      page.save_screenshot('eventos/consultar_eventos.png')
      expect(page).to have_content("#{event_list.count} registros")
    end

    scenario 'when Admin searches for Event through the Search field' do
      fill_in('Pesquisar', with: event_list.first.title)
      expect(page).to have_content("Filtrados de #{event_list.count} registros")
    end

    feature 'PDF' do 
      before(:each) do   
        click_and_wait('PDF')
      end
      
      scenario 'when Admin generates PDF', :js do 
        # expect(downloads.length).to eq(1)
        expect(download).to match(/.*\.pdf/)
      end 
      
      scenario 'generated file contains expected content', :js do  
        expect(parse_file).to have_content(event_list.first.title)
      end 
    end 
    
    feature 'Excel' do 
      before(:each) do   
        click_and_wait('Planilha Excel')
      end

      scenario 'when Admin generates Excel file', :js do 
        expect(download).to match(/.*\.xlsx/)
      end

      scenario 'generated file contains expected content', :js do    
        expect(parse_file).to have_content(event_list.first.title)
      end 
    end 
  end 

  feature 'Search filters' do 
    scenario 'when Admin searches for TITLE' do 
      fill_in('q_title_cont', with: event_list.first.title)
      click_button('Pesquisar')
      sleep 5
      expect(page).to have_content('1 registros')
    end 

    xscenario 'when Admin searches for LOCATION' do 
      select2(['Centro Comunitário Nossa Senhora Medianeira'])
      click_button('Pesquisar')
      sleep 5
      expect(page).to have_content("#{event_list.count} registros")
    end
  end 
end
