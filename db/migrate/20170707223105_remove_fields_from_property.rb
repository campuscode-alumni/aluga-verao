class RemoveFieldsFromProperty < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :price, :string
    remove_column :properties, :capacity, :string
  end
end
