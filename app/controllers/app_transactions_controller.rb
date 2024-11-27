class AppTransactionsController < ApplicationController
  def index
    # Check if user is logged in
    if session[:user_id].nil?
      redirect_to root_path, alert: "You must be logged in to view this page"
    end
    # Get db information
    @user = User.find(session[:user_id])
    @transactions = AppTransaction.where(user: session[:user_id]).order(date: :desc)
    @categories = Category.where(user: @user).exists? ? Category.where(user: @user) : []
    @balance = @transactions.sum(:amount)
  end


  def new
    @user = User.find(session[:user_id])
    @categories = Category.where(user: @user).exists? ? Category.where(user: @user) : []
  end

  def create
    @user = User.find(session[:user_id])
    @app_transaction = @user.app_transactions.create(transaction_params)
    redirect_to user_app_transactions_path @user
  end

  def show
    @transaction = AppTransaction.find(params[:id])
  end

  private
  def transaction_params
    params.expect(app_transaction: [ :amount, :category, :date, :summary, :details ])
  end
end
