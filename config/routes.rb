Rails.application.routes.draw do
  # Customer
  get '/customers', to: 'customers#index', as: 'customers'

  # Movie
  resources :movies, only: [:index, :show, :create]

  #Rental
  post '/rentals/check-out', to: 'rentals#checkout', as: 'checkout'
  post '/rentals/check-in', to: 'rentals#checkin', as: 'checkin'

end
