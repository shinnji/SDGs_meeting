Rails.application.routes.draw do
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
    # 退会確認画面
    #get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  # 論理削除用のルーティング
    #patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  end 
  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end 
  
  root  'inquiry#index'
  get   'inquiry'         => 'inquiry#index'     # 入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面


  
end
