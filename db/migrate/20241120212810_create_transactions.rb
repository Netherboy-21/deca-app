class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :app_transactions do |t|
      t.float :amount
      t.string :category
      t.timestamp :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
