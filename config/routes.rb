# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#index'
  get 'admin/', to: 'admin#index'

  namespace :pages, path: '/', as: '' do
    get :about, path: I18n.t('about', scope: :routes)
    get :activities, path: I18n.t('activities', scope: :routes)
    get :partners, path: I18n.t('partners', scope: :routes)
    get :contact, path: I18n.t('contact', scope: :routes)
    resources :events, only: %i[index show], path: I18n.t('events', scope: :routes)
  end

  devise_for :users

  namespace :admin, path_names: { edit: 'editar', new: 'novo' } do
    resources :activities, path: I18n.t('admin.activities', scope: :routes)
    resources :events, path: I18n.t('admin.events', scope: :routes) do
      collection do
        get :calendar, path: I18n.t('admin.calendar', scope: :routes)
      end
    end
  end
end
