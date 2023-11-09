Rails.application.routes.draw do
  resources :countries
  get '/country', to: 'countries#country'
end
