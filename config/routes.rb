Rails.application.routes.draw do
  resources :stations, only: :index
end
