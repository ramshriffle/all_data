require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "api/v1/restaurant_dishes#index"

  namespace :api do
    namespace :v1 do
      resource :owner, only: %i[create show update destroy] do
        get '/my_restaurant', action: :my_restaurant, on: :member
        get '/my_dishes', action: :my_dishes, on: :member
      end

      resources :users, only: %i[show]

      resource :customer, only: %i[create show update destroy]

      resource :cart, only: %i[show destroy] do
        resources :cart_items, only: %i[create show update destroy]
      end

      resources :orders, only: %i[index create show destroy] do
        resources :order_items, only: [:index]
      end

      resources :restaurants do
        get '/dishes', action: :restaurant_dishes, on: :member
      end

      resources :dishes, except: %i[destroy]
      resources :categories, only: %i[index show] do
        get '/dishes', action: :category_dishes, on: :member
      end

      resources :restaurant_dishes, only: %i[index create show edit update destroy]
    end
  end

  mount Sidekiq::Web => "/sidekiq"

  # get "*a", to: "application#not_found"

end
