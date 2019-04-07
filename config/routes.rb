Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :images
    resources :animations, only: [:index, :new, :edit, :create, :update, :destroy]
    resources :characters, only: [:index, :new, :edit, :create, :update, :destroy]
  end
end
