class AddPropertyTypeToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :property_type, :string
  end
end
