require 'rails_helper'

RSpec.describe Event, type: :model do 
  # Campos obrigatórios: title, description, start_date e location

  context 'Validações de model' do 
    it 'Não é válido sem um título' do 
      event = build(:event, title: nil)
      expect(event).to_not be_valid
    end 

    it 'Não é válido sem um local' do 
      event = build(:event, location: nil)
      expect(event).to_not be_valid
    end
  end 

  context 'Testes com travel_to' do
    it 'Evento criado no dia 24' do 
      travel_to Time.zone.local(2020, 04, 24, 2, 22, 22) do 
        @event = create(:event)
      end 
      expect(@event.created_at.strftime("%d/%m/%Y")).to eq(Date.today.tomorrow.strftime("%d/%m/%Y"))
      expect(@event.created_at).to be > Time.now
    end 

    # it 'Data de criação maior que a data atual' do 
    #   expect(@event.created_at).to be > Time.now
    # end 
  end

  context 'Campos obrigatórios em branco' do 
    it 'Verifica se é um objeto do tipo RecordInvalid' do 
      expect { create(:event, title: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end 

    it 'Verifica a mensagem de retorno do ActiveRecord' do 
      expect { create(:event, title: nil) }.to raise_error(/não pode ficar em branco/)
    end 
  end 

  it 'Verifica se os dados foram salvos no banco' do 
    expect { create(:event) }.to change{ Event.all.size }.by(1)
  end
  
  it 'Verifica se os dados são válidos' do 
    event = create(:event)
    expect(event).to be_valid
  end

  xit 'Usando o attributes_for' do 
    attrs = attributes_for(:event)
    puts attrs
  end 
end