Rails.application.routes.draw do

  root "users#home"

  resources :users do
    resources :app_transactions
  end

  get "/sign_up", to: "users#new"
  get "/login", to: "users#login"
  post "/login", to: "users#login"
  get "/logout", to: "users#logout"


end
