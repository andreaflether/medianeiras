Rails.application.routes.draw do
  devise_for :users
  get 'admin/index'
  root 'admin#index'
  get 'admin/calendar'

  resources :users, path: 'admin/users', module: :admin
  resources :events, path: 'admin/events', module: :admin
end
