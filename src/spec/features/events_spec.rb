require 'rails_helper'

RSpec.feature "Events", type: :feature, js: true do
  it 'visit the events index page' do 
    admin = create(:user, :admin)
    login_as(admin)
    visit(events_path)
    page.save_screenshot('events_path.png')
  end
end
