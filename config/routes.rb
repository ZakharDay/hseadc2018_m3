Rails.application.routes.draw do
  get 'welcome/index'

  resources :orders
  resources :order_items

  resources :carts do
    resources :cart_items
  end

  resources :users
  resources :colors

  resources :products

  resources :categories do
    resources :products do
      resources :product_items
    end
  end

  root 'welcome#index'

end
