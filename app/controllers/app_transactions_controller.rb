class AppTransactionsController < ApplicationController
  def report
    # Check if user is logged in
    if session[:user_id].nil?
      redirect_to root_path, alert: "You must be logged in to view this page"
    end
    # Get balance
    @user = User.find(session[:user_id])
    @transactions = AppTransaction.where(user: session[:user_id]).order(date: :desc)
    @balance = @transactions.where(is_income: true).sum(:amount) - @transactions.where(is_income: false).sum(:amount)
  end

  def index
    # Get db information
    @user = User.find(session[:user_id])
    @transactions = AppTransaction.where(user: session[:user_id]).order(date: :desc)
    @categories = Category.where(user: @user).exists? ? Category.where(user: @user) : []
  end

  def new
    @user = User.find(session[:user_id])
    @categories = Category.where(user: @user).exists? ? Category.where(user: @user) : []
    @transaction = @user.app_transactions.build
  end

  def create
    @user = User.find(session[:user_id])
    @app_transaction = @user.app_transactions.new(transaction_params_with_user_id)
    if @app_transaction.save
      redirect_to app_transactions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(session[:user_id])
    @transaction = @user.app_transactions.find(params[:id])
    @categories = @user.categories.where(user: @user)
  end

  def update
    @user = User.find(session[:user_id])
    @transaction = @user.app_transactions.find(params[:id])

    if @transaction.update(transaction_params_with_user_id)
      redirect_to app_transactions_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    @transaction = @user.app_transactions.find(params[:id])
    @transaction.destroy
    redirect_to app_transactions_path
  end

  def show
    @transaction = AppTransaction.find(params[:id])
  end

  private
    def transaction_params # Data received from the form
      params.expect(app_transaction: [ :amount, :category, :date, :summary, :details, :is_income  ])
    end
    def transaction_params_with_user_id # Data from form with the user id
      transaction_params.merge(user_id: session[:user_id])
    end
end
