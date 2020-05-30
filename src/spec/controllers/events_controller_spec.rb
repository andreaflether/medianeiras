require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do
  
  context 'user is not logged in' do 
    it 'GET #index returns a 302 response (not authorized)' do 
      get :index 
      expect(response).to have_http_status "302"
    end 
  end 

  context 'user is logged in ' do 
    it 'GET #index redirects to root_path' do 
      user = create(:user)
      sign_in user 
      get :index 

      expect(response).to redirect_to(root_path)
    end
  end 

  describe 'admin is logged in' do

    before do
      @admin = create(:user, :admin)
      sign_in @admin
    end
    
    context 'flash messages' do 
      it 'notice: created successfully' do
        event_params = attributes_for(:event) 
        post :create, params: { event: event_params } 
        expect(flash[:notice]).to match(/criado com sucesso/)
      end 

      it 'error' do 
        event_params = attributes_for(:event, title: nil) 
        post :create, params: { event: event_params }
        expect(flash[:error]).to match(/Há erros/)
      end 
    end

    it 'content-type JSON' do 
      event_params = attributes_for(:event)
      post :create, format: :json, params: { event: event_params } 
      expect(response.content_type).to eq('application/json')
    end

    context 'routes' do 
      it { should route(:get, 'admin/events/calendar').to(action: :calendar) } 
      it { should route(:get, 'admin/events/next_events').to(action: :next_events) }
    end 

    it 'GET #index' do
      get :index
      expect(response).to have_http_status "200"
    end 

    it 'expected to change Event.count by(1)' do 
      event_params = attributes_for(:event)
      expect { post :create, params: { event: event_params } }.to change(Event, :count).by (1) 
    end 

    it 'GET #show render template' do   
      event = create(:event)
      # p event
      get :show, params: { id: event}
      expect(response).to render_template(:show)
    end 
  end 

end
