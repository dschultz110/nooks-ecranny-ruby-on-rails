Rails.application.routes.draw do
  resources :items, only: %i[index show]
  root to: "items#index"
end
