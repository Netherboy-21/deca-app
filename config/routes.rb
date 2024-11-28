Rails.application.routes.draw do

  root "users#home"

  resources :users do
    resources :app_transactions do
      collection do
        get :report
      end
    end
    resources :categories
  end

  resource "charts" do
    collection do
      get :balances
      get :categorized_expenses
      get :categorized_income
    end
  end

  get "/login", to: "users#login_get"
  post "/login", to: "users#login_post"
  get "/logout", to: "users#logout"
  get "/sign_up", to: "users#new"
end
