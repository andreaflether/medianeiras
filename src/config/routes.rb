# frozen_string_literal: true

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

  namespace :admin, path_names: { edit: 'editar', new: 'novo' } do
    get 'zip_code', to: 'zip_code#show'
    resources :people
    resources :students
    resources :volunteers
    resources :activities
    resources :events, path: I18n.t('events', scope: :routes) do
      collection do
        get :calendar, path: I18n.t('calendar', scope: :routes)
      end
    end
    resources :locations
    resources :users
  end
end
