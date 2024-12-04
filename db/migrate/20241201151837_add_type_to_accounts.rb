class AddTypeToAccounts < ActiveRecord::Migration[8.0]
  def change
    add_column :accounts, :type, :string
  end
end
