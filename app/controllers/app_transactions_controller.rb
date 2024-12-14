class AppTransactionsController < ApplicationController
  def report
    # Check if user is logged in
    if session[:user_id].nil?
      redirect_to root_path, alert: "You must be logged in to view this page"
    end
    # Get balance
    @user = User.find(session[:user_id])
    @account = Account.find(params[:account_id])
    @categories = @user.categories
    @transactions = @account.app_transactions.order(date: :desc)
    @balance = @transactions.where(is_income: true).sum(:amount) - @transactions.where(is_income: false).sum(:amount) + @account.initial_balance
  end

  def index
    # Get db information
    @user = User.find(session[:user_id])
    @account = Account.find(params[:account_id])
    @transactions = @account.app_transactions
    @categories = Category.where(user: @user).exists? ? Category.where(user: @user) : []
  end

  def new
    # Prepare model for new page
    @user = User.find(session[:user_id])
    @categories = Category.where(user: @user).exists? ? Category.where(user: @user) : []
    @account = Account.find(params[:account_id])
    @transaction = @account.app_transactions.build
  end

  def create
    # Get post request
    @user = User.find(session[:user_id])
    @account = @user.accounts.find(params[:account_id])
    @transaction = @account.app_transactions.build(transaction_params)

    # Add transaction to database
    if @transaction.save
      redirect_to account_app_transactions_path @account
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(session[:user_id])
    @categories = Category.where(user: @user).exists? ? Category.where(user: @user) : []
    @account = Account.find(params[:account_id])
    @transaction = AppTransaction.find(params[:id])
  end

  def update
    @user = User.find(session[:user_id])
    @account = Account.find(params[:account_id])
    @transaction = @account.app_transactions.find(params[:id])

    if @transaction.update(transaction_params)
      redirect_to account_app_transactions_path @account
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    @account = Account.find(params[:account_id])
    @transaction = @account.app_transactions.find(params[:id])
    @transaction.destroy
    redirect_to account_app_transactions_path @account
  end

  def show
    @account = Account.find(params[:account_id])
    @transaction = AppTransaction.find(params[:id])
  end

  private
    def transaction_params
      params.expect(app_transaction: [ :amount, :category, :date, :summary, :details, :is_income ])
    end
end
