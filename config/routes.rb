Rails.application.routes.draw do
  devise_for :users
  resources :users

  # Defines the root path route ("/")
  root  'home#index'

  get   'welcome/index'
end
