Rails.application.routes.draw do
  root :to => 'groups#index'

  resources :groups, only: [:index, :show]
  resources :teachers, only: [:index, :show]

  get 'start', to: 'pages#start'
  get 'vk_init', to: 'pages#vk_init'
  get 'banned', to: 'pages#banned'
  get 'wrong_auth', to: 'pages#wrong_auth'

  get 'user/edit'
  put 'user/update'
end