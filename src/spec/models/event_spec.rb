require 'rails_helper'

RSpec.describe Event, type: :model do 
  context 'presence validations' do 
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end 
  
  context 'associations' do 
    it { should belong_to(:location) }
  end 

  context 'error messages' do 
    it 'ActiveRecord' do 
      expect { create(:event, location: nil) }.to raise_error(/é obrigatório/)
    end 

    it 'verifies number of error messages with no fields provided' do 
      event = build(:event, title: nil, description: nil, start_date: nil, end_date: nil, location: nil)
      event.valid?
      expect(event.errors.count).to eq(5)   
    end 
  end 
  
  it { expect { create(:event) }.to change{ Event.all.size }.by(1) }

  it 'is valid with all params' do
    event = create(:event)
    expect(event).to be_valid
  end

  context 'instance methods' do 
    it '#happening_today?' do 
      event = create(:event)
      expect(event.happening_today?).to eq(true)
    end 
  end 

  context 'happening_this_month scope' do 
    it 'should include events happening in the current month ' do   
      # events = create_list(:event, 8) 
      event = create(:event)
      expect(Event.happening_this_month).to include(event)
    end 
    
    it 'should not include events happening in the next month' do 
      event = create(:event, start_date: Date.today.next_month(months = 1), 
                             end_date: Date.today.next_month(months = 1).advance(:days => rand(1..5)))
      expect(Event.happening_this_month).not_to include(event)
    end 
  end
end