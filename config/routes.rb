Rails.application.routes.draw do
  # Customer
  get '/customers', to: 'customers#index', as: 'customers'
end
