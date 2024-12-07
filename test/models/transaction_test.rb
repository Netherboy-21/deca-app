require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test "should create transaction" do
    account = accounts(:one)
    transaction = account.app_transactions.new(name: "")
    assert transaction.save, "Did not save transaction"
  end
end
