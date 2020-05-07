Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations'
  }

  get 'welcome/index'

  resources :orders
  resources :order_items

  resources :carts do
    resources :cart_items

    member do
      get 'clear'
    end
  end

  resources :users
  resources :colors

  resources :products do
    resources :product_images

    member do
      get 'favourite'
    end
  end

  resources :categories do
    resources :products do
      resources :product_items
      resources :product_images
    end
  end

  root 'welcome#index'

end
