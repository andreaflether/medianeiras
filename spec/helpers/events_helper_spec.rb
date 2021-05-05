# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsHelper, type: :helper do
  context '#full_time' do
    let(:starts_at) { Time.now }
    let(:ends_at) { Time.now + 1.hour }
    let(:expected_time) { "#{starts_at.strftime('%H:%M')} às #{ends_at.strftime('%H:%M')}" }

    it { expect(helper.full_time(starts_at, ends_at)).to eq(expected_time) }
  end
end
