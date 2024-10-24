Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :products, only: [:index]

  resources :carts, only: [:show] do
    post :add_product, on: :collection
    delete :remove_product, on: :collection
  end
  get '/carts', to: 'carts#show'
end
