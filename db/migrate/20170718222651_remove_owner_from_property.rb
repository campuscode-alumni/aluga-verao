class RemoveOwnerFromProperty < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :owner, :string
  end
end
