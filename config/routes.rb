Rails.application.routes.draw do
  resources :items, only: %i[index show]
  resources :variants, only: %i[index show]
  resources :types, only: %i[index show]
  resources :tags, only: %i[index show]
  root to: "items#index"
end
