Rails.application.routes.draw do
  root to: 'home#index'
  resources :stations, only: :index
  resources :predictions, only: [:new, :create, :show]
end
