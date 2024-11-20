Rails.application.routes.draw do

  root "users#home"

  resources :users

  get "/sign_up", to: "users#new"
  get "/login", to: "users#login"
  post "/login", to: "users#login"
end
