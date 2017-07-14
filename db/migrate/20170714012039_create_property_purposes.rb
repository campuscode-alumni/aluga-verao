class CreatePropertyPurposes < ActiveRecord::Migration[5.1]
  def change
    create_table :property_purposes do |t|
      t.references :property, foreign_key: true
      t.references :purpose, foreign_key: true

      t.timestamps
    end
  end
end
