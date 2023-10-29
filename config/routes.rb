Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users
  resources :groups

  # Defines the root path route ("/")
  root  'home#index'

  get   'welcome/index'
  post  '/add_instrument_requirement', to: 'groups#add_instrument_requirement'
  post  '/add_user_to_group', to: 'groups#add_user_to_group', as: 'add_user_to_group'
  post  '/send_invitation_mail', to: 'groups#send_invitation_mail'
  get   '/join_group', to: 'groups#join_group'
  get   '/musician_request', to: 'groups#musician_request'
  post  '/send_request', to: 'groups#send_request'
  get   '/view_request', to: 'groups#view_request'
end
