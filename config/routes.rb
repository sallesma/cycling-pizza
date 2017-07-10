Rails.application.routes.draw do
  root to: 'home#index'

  resources :stations, only: [:show]
  resources :predictions, only: [:new, :create, :show, :index] do
    patch :evaluate, on: :member
  end

  namespace :admin do
    resources :stations, only: [:index, :show]
    resources :weathers, only: :index
  end
end
