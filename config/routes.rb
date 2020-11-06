Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # resources :pages, except: %i[show]
  get "/pages/:permalink" => "pages#permalink"
  get "/types/:name" => "types#name"

  resources :items, only: %i[index show]

  resources :variants, only: %i[index show]

  resources :types, only: %i[index]

  resources :tags, only: %i[index show]

  root to: "home#index"
end
