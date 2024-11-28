class AddTypeToAppTransaction < ActiveRecord::Migration[8.0]
  def change
    add_column :app_transactions, :is_income, :boolean
    change_column :app_transactions, :amount, :float
  end
end
