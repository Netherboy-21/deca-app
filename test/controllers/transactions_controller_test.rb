require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should create transaction" do
    user = User.find(1)
    account = user.accounts.first
    transaction = account.app_transactions

  end
end
