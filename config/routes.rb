Rails.application.routes.draw do

  resources :chat_rooms, only: [:index, :new, :create, :show ]

  root to: 'visitors#index'
  devise_for :users
  resources :users

  mount ActionCable.server => '/cable'

end
