Rails.application.routes.draw do
  root 'search_results#index'
  resources :users, only: [:show]
  resources :organizations, only: [:show]
  resources :tickets, only: [:show]
end
