Rails.application.routes.draw do
  root to: "pages#home"

  # ==============================================================================================
  # Playground
  # ==============================================================================================
  get "am-grid", to: "pages#grid", as: "grid"
  get '/react', to: 'pages#react', as: 'react'

  resources :users

  # ==============================================================================================
  # Users & User Sessions
  # ==============================================================================================
  resources :users
  resources :user_sessions, only: [:new]
  post "login", to: "user_sessions#create", as: "login"
  post "logout", to: "user_sessions#destroy", as: "logout"
end
