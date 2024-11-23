class AddSummaryToAppTransaction < ActiveRecord::Migration[8.0]
  def change
    add_column :app_transactions, :summary, :string
    add_column :app_transactions, :details, :text
  end
end
