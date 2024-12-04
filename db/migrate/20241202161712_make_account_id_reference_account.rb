class MakeAccountIdReferenceAccount < ActiveRecord::Migration[8.0]
  def change
    remove_column :accounts, :account_id, :integer
  end
end
