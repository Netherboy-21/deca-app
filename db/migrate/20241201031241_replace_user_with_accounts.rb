class ReplaceUserWithAccounts < ActiveRecord::Migration[8.0]
  def change
    rename_column :app_transactions, :user_id, :account_id
  end
end
