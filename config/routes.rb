Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  get 'store/index'

  resources :users
  resources :products

  controller :sessions do
    get "login" => :new
    post "login" => :create
    delete "logout" => :destroy
  end

  scope "(:locale)" do
    root to: 'store#index', as: 'store'

    resources :line_items
    resources :carts
    resources :orders
  end
end
