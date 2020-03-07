Rails.application.routes.draw do
  devise_for :users
  get 'admin/index'
  root 'admin#index'

  resources :users, path: 'admin/users', module: :admin
  resources :events, path: 'admin/events', module: :admin
  resources :activities, path: 'admin/activities', module: :admin
end
