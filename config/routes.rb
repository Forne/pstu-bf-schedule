Rails.application.routes.draw do
  root :to => 'pages#start'

  resources :groups, only: [:index, :show] do
    resources :users, only: [:index]
  end
  resources :teachers, only: [:index, :show]
  resources :auditoriums, only: [:index, :show]

  get 'start', to: 'pages#start'
  get 'vk_init', to: 'pages#vk_init'
  get '/auth/:provider/callback', to: 'pages#callback'
  get 'logout', to: 'pages#logout'

  get 'offline', to: 'pages#offline'
  get 'sw', to: 'js#sw'

  get 'user/edit'
  put 'user/update'
end