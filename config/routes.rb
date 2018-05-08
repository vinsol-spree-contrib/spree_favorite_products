Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace :admin do
    resources :favorite_products, only: [:index, :destroy] do
      get :users, on: :member, to: 'products#favorite_users'
    end

    resources :products do
      get :favorite_users, on: :member
    end

    resources :users do
      get :favorite_products, on: :member
    end
  end

  resources :favorite_products, only: [:index, :create, :destroy] do
    get :change_favorite_option, on: :member
  end
end
