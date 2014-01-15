Schedule::Application.routes.draw do
  namespace :vk do
    root :to => 'pages#start'

    get 'groups/:id/schedule', to: 'schedule#group'
    get 'teachers/:id/schedule', to: 'schedule#teacher'

    get 'init', to: 'pages#init'
    get 'banned', to: 'pages#banned'
    get 'wrong_auth', to: 'pages#wrong_auth'

    get 'user/edit'
    put 'user/update'
  end

  scope :module => 'web' do
    root :to => 'groups#index'
    get 'groups', to: 'groups#index'
    get 'groups/:id/schedule', to: 'groups#schedule'
    get 'teachers', to: 'teachers#index'
    get 'teachers/:id/schedule', to: 'teachers#schedule'
  end
end
