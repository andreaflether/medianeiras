# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Activity, type: :model do
  let(:activity) { create(:activity) }

  describe 'validations' do
    context 'name' do
      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name) }
    end

    context 'max_capacity' do
      it { should validate_presence_of(:max_capacity) }
      it { should validate_numericality_of(:max_capacity).only_integer.is_greater_than_or_equal_to(1) }
    end

    context 'description' do
      it { should validate_presence_of(:description) }
    end

    context 'starts_at' do
      it { should validate_presence_of(:starts_at) }
    end

    context 'ends_at' do
      it { should validate_presence_of(:ends_at) }
    end
  end

  describe 'enums' do
    context 'status' do
      it { should define_enum_for(:status).with_values(%i[active closed]) }
    end
  end
end
