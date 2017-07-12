class CreatePriceRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :price_ranges do |t|
      t.references :property, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.decimal :daily_rate

      t.timestamps
    end
  end
end
