Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'images#index', as: :root
  resources :images, only: [:index, :show, :new, :edit, :update] do
    collection do
      get 'search'
      get 'select_animation'
      get 'select_characters'
    end
  end

  namespace :admin do
    resources :images
    resources :animations, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :characters, only: [:index, :new, :edit, :create, :update, :destroy]
  end
end
