require 'rails_helper'

RSpec.describe Location, type: :model do
  subject { create(:location) }

  context 'presence validations' do 
    it { should validate_presence_of(:address) }
  end 

  context 'uniqueness validations' do 
    it { should validate_uniqueness_of(:description) }
  end 

  it { expect { create(:location) }.to change{ Location.all.size }.by(1) }

  it { is_expected.to be_valid }
end
