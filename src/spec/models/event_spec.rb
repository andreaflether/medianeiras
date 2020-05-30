require 'rails_helper'

RSpec.describe Event, type: :model do 
  # Campos obrigatórios: title, description, start_date, end_date e location

  context 'validations' do 
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:location) }
  end 

  context 'error messages' do 
    it 'verifies ActiveRecord error message' do 
      expect { create(:event, title: nil) }.to raise_error(/não pode ficar em branco/)
    end 

    it 'verifies the number of error messages with no information provided' do 
      event = build(:event, title: nil, description: nil, start_date: nil, end_date: nil, location: nil)
      event.valid?
      expect(event.errors.count).to eq(5)   
    end 
  end 
  
  it { expect { create(:event) }.to change{ Event.all.size }.by(1) }

  it 'is valid with title, description, start_date, end_date and location' do 
    event = create(:event)
    expect(event).to be_valid
  end

  context 'instance methods' do 
    it '#is_today?' do 
      event = create(:event)
      expect(event.is_today?).to eq(true)
    end 
  end 

  context 'this_month scope' do 
    it 'should include events happening in the current month' do 
      # events = create_list(:event, 8) 
      event = create(:event)
      expect(Event.this_month).to include(event)
    end 

    it 'should not include event happening in the next month' do 
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