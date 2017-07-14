class RemovePropertyTypeFromProperty < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :property_type, :string
  end
end
