require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do
  before do
    @admin = create(:user, :admin)
    sign_in @admin
  end

  context 'rotas adicionais' do 
    it { should route(:get, 'admin/events/calendar').to(action: :calendar) } 
    it { should route(:get, 'admin/events/next_events').to(action: :next_events) }
  end 

  describe "POST #create" do
    context "com atributos válidos" do
      it "cria um novo evento" do
        event_params = attributes_for(:event)
        expect { post :create, params: { event: event_params } }.to change(Event, :count).by (1) 
      end
      
      it "redireciona para o evento criado" do
        post :create, params: { event: attributes_for(:event) } 
        expect(response).to redirect_to Event.last
      end
    end
    
    context "com atributos inválidos" do
      it "não salva o evento" do
        expect {
          post :create, params: { event: attributes_for(:event, title: nil) }
        }.to_not change(Event, :count)
      end
      
      it "renderiza novamente a página new" do
        post :create, params: { event: attributes_for(:event, title: nil) }
        expect(response).to render_template :new
      end
    end  
  end 

  describe 'DELETE #destroy' do
    before :each do
      @event = create(:event)
    end
    
    it "deleta o evento" do
      expect { delete :destroy, params: { id: @event } }.to change(Event, :count).by(-1)
    end
      
    it "redireciona para events#index após exclusão" do
      delete :destroy, params: { id: @event }
      expect(response).to redirect_to events_url
    end
  end
end
