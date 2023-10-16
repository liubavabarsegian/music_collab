Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :groups

  # Defines the root path route ("/")
  root  'home#index'

  get   'welcome/index'
  post  '/add_instrument_requirement', to: 'groups#add_instrument_requirement'
end
