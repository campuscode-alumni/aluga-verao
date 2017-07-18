class CreatePropertyReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :property_reviews do |t|
      t.references :property, foreign_key: true
      t.references :user, foreign_key: true
      t.text :comment
      t.integer :rating

      t.timestamps
    end
  end
end
