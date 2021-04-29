# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'

  namespace :pages, path: '/', as: '' do
    get :about, path: I18n.t('about', scope: :routes)
    get :activities, path: I18n.t('activities', scope: :routes)
    get :partners, path: I18n.t('partners', scope: :routes)
    get :events, path: I18n.t('events', scope: :routes)
    get :contact, path: I18n.t('contact', scope: :routes)
  end

  resources :suggestions
  resources :promulher_forms
  devise_for :users

  # Admin main route
  get 'admin/', to: 'admin#index'

  namespace :admin, path_names: { edit: 'editar', new: 'novo' } do
    get 'zip_code', to: 'zip_code#show'
    resources :people
    resources :students
    resources :volunteers
    resources :activities
    resources :events, path: I18n.t('admin.events', scope: :routes) do
      collection do
        get :calendar, path: I18n.t('admin.calendar', scope: :routes)
      end
    end
    resources :locations
    resources :users
  end
end
