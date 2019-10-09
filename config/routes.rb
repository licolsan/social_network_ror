Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users, controllers: {
    confirmations: "confirmations",
    omniauth_callbacks: "auths"
  }

  resources :users, except: [ :new, :create, :destroy ]
end
