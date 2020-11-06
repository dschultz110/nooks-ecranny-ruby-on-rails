Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :items, only: %i[index show]
  resources :variants, only: %i[index show]
  resources :types, only: %i[index show]
  resources :tags, only: %i[index show]
  root to: "items#index"
end
