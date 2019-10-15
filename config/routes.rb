Rails.application.routes.draw do
  
  root 'pages#index'
  devise_for :users, controllers: {
    confirmations: "confirmations",
    omniauth_callbacks: "auths"
  }

  resources :users, except: [ :new, :create, :destroy ]

  get "user/follow/:type" => "follow_relationships#index", as: "follow_list"
  post "follow/:id" => "follow_relationships#create", as: "follow"
  delete "unfollow/:id" => "follow_relationships#destroy", as: "unfollow"

  resources :posts do
    resources :comments, except: [ :index, :new ] do
      resources :comments, only: [ :create ]
    end
  end
  
end
