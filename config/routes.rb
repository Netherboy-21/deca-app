Rails.application.routes.draw do

  root "users#home"

  resources :users do
    resources :app_transactions
    resources :categories
  end

  resource "charts" do
    get "/balances", to: "charts#balances"
    get "/categories_expenses", to: "charts#categorized_expenses"
    get "/categories_income", to: "charts#categorized_income"
  end

  get "/sign_up", to: "users#new"
  get "/login", to: "users#login_get"
  post "/login", to: "users#login_post"
  get "/logout", to: "users#logout"


end
