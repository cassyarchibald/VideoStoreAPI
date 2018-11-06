Rails.application.routes.draw do
  # Customer
  get '/customers', to: 'customers#index', as: 'customers'

  # Movie
  resources :movies, only: [:index, :show, :create]
end
