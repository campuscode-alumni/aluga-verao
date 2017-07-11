class CreateProposals < ActiveRecord::Migration[5.1]
  def change
    create_table :proposals do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :daily_rate
      t.references :property, foreign_key: true

      t.timestamps
    end
  end
end
