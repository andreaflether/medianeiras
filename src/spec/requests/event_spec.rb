# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :request do
  before(:each) do 
    admin = create(:user, :superadmin)
    login_as(admin)
  end

  let(:event) { create(:event) }
  let(:valid_attributes) { build(:event).attributes }
  let(:invalid_attributes) { attributes_for(:event, title: '') }

  describe 'GET /index' do
    it 'renders a successful response' do
      get admin_events_url
      expect(response).to be_successful
    end
  end

  describe 'GET /event/:id' do
    it 'renders a successful response' do
      get admin_event_path(event)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_admin_event_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_admin_event_url(event)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Event' do
        expect do
          post admin_events_url, params: { event: valid_attributes }
        end.to change(Event, :count).by(1)
      end

      it 'redirects to the created event' do
        post admin_events_url, params: { event: valid_attributes }
        expect(response).to redirect_to(admin_event_url(Event.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Event' do
        expect do
          post admin_events_url, params: { event: invalid_attributes }
        end.to change(Event, :count).by(0)
      end

      it 'renders the :new template' do
        post admin_events_url, params: { event: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { build(:event, title: 'New title').attributes }

      it 'redirects to the event' do
        patch admin_event_url(event), params: { event: new_attributes }
        event.reload
        expect(response).to redirect_to(admin_event_url(event))
      end
    end

    context 'with invalid parameters' do
      it 'renders the :edit template' do
        patch admin_event_url(event), params: { event: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested event' do
      event = Event.create! valid_attributes
      expect { delete admin_event_url(event) }.to change(Event, :count).by(-1)
    end

    it 'redirects to the events index page' do
      event = Event.create! valid_attributes
      delete admin_event_url(event)
      expect(response).to redirect_to(admin_events_url)
    end
  end

  describe 'GET /calendar' do 
    it 'renders a successful response' do 
      get calendar_admin_events_url 
      expect(response).to be_successful
    end
  end
end