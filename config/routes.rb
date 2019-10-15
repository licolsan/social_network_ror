Rails.application.routes.draw do
  
  root 'pages#index'
  devise_for :users, controllers: {
    confirmations: "confirmations",
    omniauth_callbacks: "auths"
  }

  resources :users, except: [ :new, :create, :destroy ]

  get "users/follow/:type" => "follow_relationships#index", as: "follow_list"
  post "users/:id/follow" => "follow_relationships#create", as: "follow"
  delete "users/:id/unfollow" => "follow_relationships#destroy", as: "unfollow"

  resources :posts do
    resources :comments, except: [ :index, :new ] do
      resources :comments, only: [ :create ]
    end
  end
  
end
