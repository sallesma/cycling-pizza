Rails.application.routes.draw do
  root to: 'home#index'
  resources :predictions, only: [:new, :create, :show]
  resources :stations, only: [:show]

  namespace :admin do
    resources :stations, only: [:index, :show]
    resources :weathers, only: :index
  end
end
