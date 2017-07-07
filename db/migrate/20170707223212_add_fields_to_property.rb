class AddFieldsToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :title, :string
    add_column :properties, :daily_rate, :decimal
    add_column :properties, :maximum_guests, :integer
  end
end
