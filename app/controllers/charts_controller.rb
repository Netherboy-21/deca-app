class ChartsController < ApplicationController

  # Paths to return data for graphs

  def balances
    # Get transactions from user
    @transactions = AppTransaction.where(user: session[:user_id])
    # Generate balances array
    @balance = 0
    @balances = {}
    @transactions.order(:date).each do |transaction|
      @balance += transaction.amount * (transaction.is_income ? 1 : -1)
      @balances[transaction.date.strftime("%F")] = @balance.to_i
    end
    @balances = @balances.sort_by { |_key, value| value }
    # Return json for chart
    render json: @balances
  end

  def categorized_expenses
    @transactions = AppTransaction.where(user: session[:user_id], is_income: false)
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
    @transactions = AppTransaction.where(user: session[:user_id], is_income: true)
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
