Rails.application.routes.draw do
  get 'pages/index'
  resources :suggestions
  resources :promulher_forms
  devise_for :users
  
  get 'admin/index'
  root 'pages#index'
  get '/contato', to: 'pages#contact'
  get '/eventos', to: 'pages#events'

  # Admin main route
  get 'admin/', to: 'admin#index'
  
  scope module: 'admin' do
    get 'zip_code', to: 'zip_code#show'
    resources :people, path: 'admin/people' 
    resources :students, path: 'admin/students'
    resources :volunteers, path: 'admin/volunteers'
    resources :activities, path: 'admin/activities'
    get 'admin/events/calendar', as: :calendar, to: 'events#calendar'
    get 'admin/events/next_events', as: :next_events, to: 'events#next_events'
    resources :events, path: 'admin/events' do 
      get :autocomplete_event_location, :on => :collection
    end 
    resources :users, path: 'admin/users'
  end 
end
