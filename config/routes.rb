Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :users
  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end 
end
