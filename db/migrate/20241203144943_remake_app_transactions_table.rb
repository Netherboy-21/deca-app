class RemakeAppTransactionsTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :app_transactions
    create_table :app_transactions do |t|
      t.float :amount
      t.string :category
      t.date :date
      t.string :summary
      t.text :details
      t.boolean :is_income

      t.references :account, index: true
    end
  end
end
