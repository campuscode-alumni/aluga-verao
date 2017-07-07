class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :city
      t.string :state
      t.string :type
      t.text :description
      t.decimal :price
      t.string :photo
      t.integer :capacity
      t.integer :minimun_rent
      t.integer :maximum_rent
      t.text :rules
      t.string :rent_purpose

      t.timestamps
    end
  end
end
