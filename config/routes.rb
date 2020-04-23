Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  resources :orders
  resources :order_items

  resources :carts do
    resources :cart_items
  end

  resources :users
  resources :colors

  resources :products do
    resources :product_images
  end

  resources :categories do
    resources :products do
      resources :product_items
      resources :product_images
    end
  end

  root 'welcome#index'

end
