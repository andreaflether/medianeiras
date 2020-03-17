Rails.application.routes.draw do
  resources :suggestions
  resources :promulher_forms
  devise_for :users
  get 'admin/index'
  root 'admin#index'


  resources :people, path: 'admin/people', module: :admin
  resources :students, path: 'admin/students', module: :admin
  resources :volunteers, path: 'admin/volunteers', module: :admin
  resources :activities, path: 'admin/activities', module: :admin
  get 'admin/events/calendar', as: :calendar, to: 'admin/events#calendar'
  resources :events, path: 'admin/events', module: :admin
  resources :users, path: 'admin/users', module: :admin

end
