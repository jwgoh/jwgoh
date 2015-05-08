Rails.application.routes.draw do
  root to: 'pages#home'

  resources :users

  resources :user_sessions, only: [:new]
  post 'login', to: 'user_sessions#create', as: 'login'
  post 'logout', to: 'user_sessions#destroy', as: 'logout'
end
