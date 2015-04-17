Rails.application.routes.draw do
  resource :application, only: [:show]
  root to: 'application#show'
  get 'application/show'

  resources :user
end
