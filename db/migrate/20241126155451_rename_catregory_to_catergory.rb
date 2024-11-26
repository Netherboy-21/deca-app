class RenameCatregoryToCatergory < ActiveRecord::Migration[8.0]
  def change
    rename_table :catregories, :categories
  end
end
