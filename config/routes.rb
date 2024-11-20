Rails.application.routes.draw do
  resources :users

  root "users#home"

  get "/sign_up", to: "users#new"

  get "/login", to: "users#login"
end
