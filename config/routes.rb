Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # resources :pages, except: %i[show]
  get "/pages/:permalink" => "pages#permalink"
  get "/types/:name" => "types#name"

  post "/add_to_cart/:id", to: "items#add_to_cart", as: "add_to_cart"
  delete "/remove_from_cart/:id", to: "items#remove_from_cart", as: "remove_from_cart"
  get "/cart", to: "items#cart", as: "cart"

  resources :items, only: %i[index show]

  resources :variants, only: %i[index show]

  resources :types, only: %i[index]

  resources :tags, only: %i[index show]

  root to: "home#index"
end
