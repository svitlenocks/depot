Rails.application.routes.draw do
  root to: 'store#index', as: 'store'
  get 'admin' => 'admin#index'

  get 'store/index'

  resources :users
  resources :products
  resources :line_items
  resources :carts
  resources :orders

  controller :sessions do
    get "login" => :new
    post "login" => :create
    delete "logout" => :destroy
  end
end
