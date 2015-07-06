Rails.application.routes.draw do
  root to: "pages#home"

  # ==============================================================================================
  # Static Pages
  # ==============================================================================================
  get "about", to: "pages#about"

  # ==============================================================================================
  # Playground
  # ==============================================================================================
  get "am-grid", to: "pages#grid", as: "grid"
  get "react", to: "pages#react", as: "react"

  resources :users

  # ==============================================================================================
  # Users & User Sessions
  # ==============================================================================================
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  # ==============================================================================================
  # Resources
  # ==============================================================================================
  resources :meetups
end
