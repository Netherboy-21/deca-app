class RenameTransactionsToAppTransactions < ActiveRecord::Migration[8.0]
  def change
    rename_table :app_transactions, :app_transactions
  end
end
