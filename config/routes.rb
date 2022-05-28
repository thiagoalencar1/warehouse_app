Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :warehouses, only: %i[show new create edit update destroy]
  resources :suppliers, only: %i[index show new create edit update]
  resources :product_models, onyl: %i[index show new create]

  resources :orders, only: %i[new create show index edit update] do
    get 'search', on: :collection
  end
end
