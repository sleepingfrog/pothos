Rails.application.routes.draw do
  resources :candies, only: [:index, :new, :create, :show]
  resources :authors
  resources :posts
  namespace :namespaced do
    resources :posts, only: [:index]
  end
end
