require 'rails_helper'

RSpec.describe Event, type: :model do 
  # Campos obrigatórios: title, description, start_date, end_date e location

  context 'Validações de model' do 
    it 'Não é válido sem um título' do 
      event = build(:event, title: nil)
      expect(event).to_not be_valid
    end 

    it 'Não é válido sem um local' do 
      event = build(:event, location: nil)
      expect(event).to_not be_valid
    end

    it 'Não é válido sem uma data de início' do 
      event = build(:event, start_date: nil)
      expect(event).to_not be_valid
    end 

    it 'Não é válido sem uma data final' do 
      event = build(:event, end_date: nil)
      expect(event).to_not be_valid
    end 

    it 'Não é válido sem uma descrição' do 
      event = build(:event, description: nil)
      expect(event).to_not be_valid
    end 
  end 

  context 'Mensagens de erro' do 
    it 'Verifica se é um objeto do tipo RecordInvalid' do 
      expect { create(:event, title: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end 

    it 'Verifica a mensagem de retorno do ActiveRecord' do 
      expect { create(:event, title: nil) }.to raise_error(/não pode ficar em branco/)
    end 

    it 'Verifica a quantidade de erros com todos os atributos obrigatórios em branco' do 
      event = build(:event, title: nil, description: nil, start_date: nil, end_date: nil, location: nil)
      event.valid?
      expect(event.errors.count).to eq(5)   
    end 
  end 

  it 'Verifica se os dados foram salvos no banco' do 
    expect { create(:event) }.to change{ Event.all.size }.by(1)
  end
  
  it 'É válido com todos os atributos preenchidos' do 
    event = create(:event)
    expect(event).to be_valid
  end

  it '#is_today?' do 
    event = create(:event)
    expect(event.is_today?).to eq(true)
  end 

  context 'Escopo this_month' do 
    it 'Deve incluir evento marcado para mês atual' do 
      # events = create_list(:event, 8) 
      event = create(:event)
      expect(Event.this_month).to include(event)
    end 

    it 'Não inclui evento marcado para próximo mês' do 
      event = create(:event, start_date: Date.today.next_month(months = 1), 
                             end_date: Date.today.next_month(months = 1).advance(:days => rand(1..5)))
      expect(Event.this_month).not_to include(event)
    end 
  end

  xit 'Usando o attributes_for' do 
    attrs = attributes_for(:event)
    puts attrs
  end 
end