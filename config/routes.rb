require "sidekiq/web"

Rails.application.routes.draw do
  get 'hotels/index'
  resources :gifts do
    collection do
      get :wrapped
      get :nowrapped
    end
  end
  resources :candies, only: [:index, :new, :create, :show]
  resources :authors
  resources :posts
  namespace :namespaced do
    resources :posts, only: [:index]
  end

  resources :jobs, only: [:index] do
    collection do
      post :aoi
      post :itadori
      post :ume
    end
  end
  mount Sidekiq::Web => "/sidekiq"
end
