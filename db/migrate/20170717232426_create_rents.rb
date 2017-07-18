class CreateRents < ActiveRecord::Migration[5.1]
  def change
    create_table :rents do |t|
      t.references :proposal, foreign_key: true

      t.timestamps
    end
  end
end
