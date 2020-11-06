Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :items, only: %i[index show], param: :name
  resources :variants, only: %i[index show], param: :name
  resources :types, only: %i[index show], param: :name
  resources :tags, only: %i[index show], param: :name
  root to: "items#index"
end
