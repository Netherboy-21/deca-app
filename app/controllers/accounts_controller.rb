class AccountsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @accounts = @user.accounts

    # Generate balances across accounts
    @balances = {}
    @accounts.each do |account|
      @transactions_sum = account.app_transactions.where(is_income: true).sum(:amount) - account.app_transactions.where(is_income: false).sum(:amount)
      @balances.merge!({ account.name => @transactions_sum + account.initial_balance })
    end
  end

  def show
    redirect_to account_app_transactions_path params[:id]
  end

  def new
    @user = User.find(session[:user_id])
    @account = @user.accounts.build
  end

  def create
    @user = User.find(session[:user_id])
    @account = @user.accounts.build(account_params_with_user_id)

    if @account.save
      redirect_to accounts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(session[:user_id])
    @account = @user.accounts.find(params[:id])
  end

  def update
    @user = User.find(session[:user_id])
    @account = @user.accounts.find(params[:id])

    if @account.update(account_params_with_user_id)
      redirect_to accounts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    @account = @user.accounts.find(params[:id])

    @account.destroy

    redirect_to accounts_path, status: :see_other
  end

  private
    def account_params
      params.expect(account: [ :name, :account_type, :initial_balance ])
    end

    def account_params_with_user_id
      account_params.merge(user_id: session[:user_id])
    end
end
