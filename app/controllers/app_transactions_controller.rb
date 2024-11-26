class AppTransactionsController < ApplicationController
  def index
    if session[:user_id].nil?
      redirect_to root_path, alert: "You must be logged in to view this page"
    end
    @user = User.find(session[:user_id])
    @app_transactions = AppTransaction.where(user: session[:user_id]).order(date: :desc)
    @balance = 0
    @balances = {}
    AppTransaction.where(user: session[:user_id]).order(:date).each do |transaction|
      @balance += transaction.amount
      @balances[transaction.date.strftime("%F")] = @balance.to_i
    end
  end

  def new
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.find(session[:user_id])
    @app_transaction = @user.app_transactions.create(transaction_params)
    redirect_to @app_transaction
  end

  def show
    @transaction = AppTransaction.find(params[:id])
  end

  private
  def transaction_params
    params.expect(app_transaction: [ :amount, :category, :date, :summary, :details ])
  end
end