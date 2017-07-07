class AddOwnerToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :owner, :string
  end
end
