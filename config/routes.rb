Rails.application.routes.draw do
  resources :posts
  namespace :namespaced do
    resources :posts, only: [:index]
  end
end
