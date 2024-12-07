class ChartsController < ApplicationController

  # Paths to return data for graphs

  def balances
    # Get transactions from account
    @account = Account.find(params[:account_id])
    @transactions = @account.app_transactions
    # Generate balances array
    @balance = @account.initial_balance
    @balances = Hash.new
    @transactions.order(:date).each do |transaction|
      @balance += transaction.amount * (transaction.is_income ? 1 : -1)
      @balances[transaction.date.strftime("%F")] = @balance
    end
    @balances = @balances.sort_by { |_key, value| value }
    # Return json for chart
    render json: @balances
  end

  def categorized_expenses
    @account = Account.find(params[:account_id])
    @transactions = @account.app_transactions.where(is_income: false)
    @categorized = Hash.new
    @transactions.each do |transaction|
      if !@categorized[transaction.category].nil?
        @categorized[transaction.category] += transaction.amount
      else
        @categorized[transaction.category] = transaction.amount
      end
    end
    render json: @categorized
  end

  def categorized_income
    @account = Account.find(params[:account_id])
    @transactions = @account.app_transactions.where(is_income: true)
    @categorized = Hash.new
    @transactions.each do |transaction|
      if !@categorized[transaction.category].nil?
        @categorized[transaction.category] += transaction.amount
      else
        @categorized[transaction.category] = transaction.amount
      end
    end
    render json: @categorized
  end
end
