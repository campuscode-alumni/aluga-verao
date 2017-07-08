class RemoveTypeFromProperty < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :type, :string
  end
end
