# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    context 'title' do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title).is_at_least(1).is_at_most(255) }
    end

    context 'description' do
      it { should validate_presence_of(:description) }
    end

    context 'start_date' do
      it { should validate_presence_of(:start_date) }
    end

    context 'description' do
      it { should validate_presence_of(:end_date) }
    end
  end

  context 'associations' do
    it { should belong_to(:location) }
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
                             end_date: Date.today.next_month(months = 1).advance(days: rand(1..5)))
      expect(Event.happening_this_month).not_to include(event)
    end
  end
end
