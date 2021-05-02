# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'validations' do
    context 'description' do
      it { should validate_presence_of(:description) }
      it { should validate_uniqueness_of(:description) }
    end

    context 'address' do
      it { should validate_presence_of(:address) }
    end
  end

  describe 'associations' do
    it { should have_many(:events) }
    it { should have_many(:activities) }
  end
end
