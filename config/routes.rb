Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'images#index', as: :root
  resources :images, only: [:index, :show, :new, :create, :edit, :update] do
    collection do
      get 'search'
      get 'select_animation'
      get 'select_characters'
    end
  end

  namespace :admin do
    root to: 'images#index', as: :root
    get 'login', to: 'sessions#new',  as: :new_session
    post 'login', to: 'sessions#create', as: :session
    delete 'logout', to: 'sessions#destroy', as: :destroy_session
    resources :images
    resources :animations, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :characters, only: [:index, :new, :edit, :create, :update, :destroy]
  end
  get '*anything' => 'errors#routing_error'
end
