Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :warehouses, only: %i[show new create edit update destroy] do
    resources :stock_products_destinations, only: %i[create]
  end
  resources :suppliers, only: %i[index show new create edit update]
  resources :product_models, onyl: %i[index show new create]

  resources :orders, only: %i[new create show index edit update] do
    resources :order_items, only: [:new, :create]
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :warehouses, only: [:show, :index]
    end
  end

end
