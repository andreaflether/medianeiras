# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create(:event) }

  describe 'validations' do
    context 'title' do
      it { should validate_presence_of(:title) }
    end

    context 'description' do
      it { should validate_presence_of(:description) }
    end

    context 'scheduled_for' do
      it { should validate_presence_of(:scheduled_for) }
    end

    context 'starts_at' do
      it { should validate_presence_of(:starts_at) }
    end

    context 'ends_at' do
      it { should validate_presence_of(:ends_at) }
    end
  end

  context 'custom validations' do
    let(:invalid_time) { build(:event, starts_at: Time.now, ends_at: Time.now - 1.hour) }

    it do
      invalid_time.validate
      expect(invalid_time.errors[:ends_at]).to include(I18n.t('admin.events.ends_at.invalid_time'))
    end
  end

  context 'associations' do
    it { should belong_to(:location) }
  end

  context 'nested_attributes' do
    it { should accept_nested_attributes_for(:location) }
  end

  describe 'virtual attributes' do
    context 'start_date' do
      it { should respond_to(:start_date) }
      it { expect(event.start_date).to be_an_instance_of(DateTime) }
    end

    context 'end_date' do
      it { should respond_to(:end_date) }
      it { expect(event.end_date).to be_an_instance_of(DateTime) }
    end

    context 'location_selection_type' do
      it { should respond_to(:location_selection_type) }
    end
  end

  context 'happening_this_month scope' do
    let(:next_month_event) { create(:event, scheduled_for: Date.today.next_month(months = 1)) }
    it { expect(Event.happening_this_month).to include(event) }

    it { expect(Event.happening_this_month).not_to include(next_month_event) }
  end

  context '#datetime_from_date_and_time' do
    it { expect(event.datetime_from_date_and_time(event.scheduled_for, event.starts_at)).to be_an_instance_of(DateTime) }
  end
end
