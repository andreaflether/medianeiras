require 'rails_helper'

RSpec.describe Event, type: :model do 
  # Campos obrigatórios: title, description, start_date, end_date e location

  context 'validações' do 
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:location) }
  end 

  context 'mensagens de erro' do 
    it 'verifica a mensagen de erro do ActiveRecord' do 
      expect { create(:event, title: nil) }.to raise_error(/não pode ficar em branco/)
    end 
    
    it 'verifica o número de mensagens de erro com nenhum dos campos obrigatórios preenchidos' do 
      event = build(:event, title: nil, description: nil, start_date: nil, end_date: nil, location: nil)
      event.valid?
      expect(event.errors.count).to eq(5)   
    end 
  end 
  
  it { expect { create(:event) }.to change{ Event.all.size }.by(1) }

  it 'é válido com título, descrição, data de início, data do término e local' do
    event = create(:event)
    expect(event).to be_valid
  end

  context 'métodos de instância' do 
    it '#is_today?' do 
      event = create(:event)
      expect(event.is_today?).to eq(true)
    end 
  end 

  context 'escopo this_month' do 
    it 'deve incluir eventos com data marcada para o mês atual' do   
      # events = create_list(:event, 8) 
      event = create(:event)
      expect(Event.this_month).to include(event)
    end 
    
    it 'não deve incluir eventos marcados para o próximo mês' do 
      event = create(:event, start_date: Date.today.next_month(months = 1), 
                             end_date: Date.today.next_month(months = 1).advance(:days => rand(1..5)))
      expect(Event.this_month).not_to include(event)
    end 
  end
end