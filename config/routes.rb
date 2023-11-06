Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users
  resources :groups
  resources :invitations, only: [:index, :destroy]
  resources :requests, only: [:index, :destroy]

  # Defines the root path route ("/")
  root  'home#index'
  get   'welcome/index'

  post  '/add_instrument_requirement', to: 'groups#add_instrument_requirement'
  post  '/add_user_to_group', to: 'groups#add_user_to_group', as: 'add_user_to_group'
  post  '/send_invitation_mail', to: 'invitations#send_invitation_mail'
  get   '/join_group', to: 'invitations#join_group'
  get   'requests/show'
  post  'requests/create'
  get   'requests/new'
  post  'requests/accept'
  post  'requests/deny'
  get   'requests/accepted'
  get   'requests/denied'
  post  '/leave_group', to: 'groups#leave_group'
end
