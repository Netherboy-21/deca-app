class CreateCatregories < ActiveRecord::Migration[8.0]
  def change
    create_table :catregories do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
