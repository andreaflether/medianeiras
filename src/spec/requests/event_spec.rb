require 'rails_helper'

RSpec.describe 'Eventos - JSON', type: :request do 
  before(:each) do 
    admin = create(:user, :admin)
    login_as(admin)
  end

  describe 'GET /admin/events' do 
    it '200' do 
      get events_path, as: :json
      expect(response).to have_http_status(200)
    end

    it 'retorna evento(s) com o schema esperado' do 
      create_list(:event, 3)
      get events_path, as: :json
      expect(response).to match_json_schema('events/index')
    end 
  end 
end