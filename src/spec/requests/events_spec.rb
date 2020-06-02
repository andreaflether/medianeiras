require 'rails_helper'

RSpec.describe "Events", type: :request do  
  describe "GET /events" do
    before(:each) do 
      admin = create(:user, :admin)
      login_as(admin)
    end 

    it "eventos - JSON 200 OK" do 
      get "/admin/events.json"
      expect(response.body).to include_json([
        id: (be_kind_of Integer),
        title: (be_kind_of String),
        description: (be_kind_of String),
        start: (be_kind_of String),
        end: (be_kind_of String)
      ])
    end 
  end
end
