Rails.application.routes.draw do
  get 'notifications/index'
  resources :notifications, only: [:index, :update]
  get 'search' => 'posts#search'
  get 'inquiry/index'
  get 'inquiry/confirm'
  get 'inquiry/thanks'
  get 'about' => 'home#about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :users do 
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end 
  
  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end 
  
  root  'inquiry#index'
  get   'inquiry'         => 'inquiry#index'     # 入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面

  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  
end
