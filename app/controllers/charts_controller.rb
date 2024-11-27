class ChartsController < ApplicationController
  def balances
    # Get transactions from user
    @transactions = AppTransaction.where(user: session[:user_id])
    # Generate balances array
    @balance = 0
    @balances = {}
    @transactions.order(:date).each do |transaction|
      @balance += transaction.amount
      @balances[transaction.date.strftime("%F")] = @balance.to_i
    end
    @balances = @balances.sort_by { |_key, value| value }
    # Return json for chart
    render json: @balances
  end
end
