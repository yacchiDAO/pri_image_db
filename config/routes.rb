Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  root to: "images#index", as: :root
  get "what", to: "home#index"
  resources :images, only: [:index, :show, :new, :create, :edit, :update] do
    collection do
      get "search"
      get "select_animation"
      get "select_characters"
    end
  end

  resources :animations, only: [:index, :show] do
    member do
      get "episode/:episode_id", to: "animations#episode", as: :episode
    end
  end

  namespace :api do
    resources :images, only: [:index]
    get :random_image, to: "images#random", as: :random
  end

  namespace :admin do
    root to: "images#index", as: :root
    get "login", to: "sessions#new", as: :new_session
    post "login", to: "sessions#create", as: :session
    delete "logout", to: "sessions#destroy", as: :destroy_session
    resources :images
    resources :animations, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :characters, only: [:index, :new, :edit, :create, :update, :destroy]
  end
  get "*anything" => "errors#routing_error"
end
