Rails.application.routes.draw do
  root to: 'store#index', as: 'store'

  get 'store/index'

  resources :products
  resources :line_items
  resources :carts
end
