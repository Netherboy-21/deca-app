class FixErrorsCausedByPreviousMigraiton < ActiveRecord::Migration[8.0]
  def change
    remove_column :accounts, :account_id, :integer
    remove_column :app_transactions, :account_id, :integer
    add_reference :app_transactions, :account, index: true
  end
end
