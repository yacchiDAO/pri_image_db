Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index', as: :root
  resources :images, only: [:index, :show] do
    collection do
      get 'character'
      get 'line'
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
